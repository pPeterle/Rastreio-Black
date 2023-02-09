import 'package:background_fetch/background_fetch.dart';
import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/utils/services/notification_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../extermal/datasources/correios_rastreio_datasource.dart';
import '../../extermal/datasources/hive_datasource.dart';
import '../../infra/repositories/delivery_repository_impl.dart';
import '../../infra/repositories/track_repository_impl.dart';

class FetchJob {
  final GetAllDeliveriesUsecase getAllDeliveriesUsecase;
  final SaveDeliveryUsecase saveDeliveryUsecase;
  final NotificationService notificationService;

  FetchJob(
    this.getAllDeliveriesUsecase,
    this.saveDeliveryUsecase,
    this.notificationService,
  ) {
    configure();
  }

  void configure() async {
    BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          startOnBoot: true,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY,
        ), (String taskId) async {
      await fetchData();
      BackgroundFetch.finish(taskId);
    }, (String taskId) {
      BackgroundFetch.finish(taskId);
    });

    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }

  @pragma('vm:entry-point')
  static void backgroundFetchHeadlessTask(HeadlessTask task) async {
    String taskId = task.taskId;
    bool isTimeout = task.timeout;
    if (isTimeout) {
      BackgroundFetch.finish(taskId);
      return;
    }

    await Hive.initFlutter();

    final notification = NotificationService();
    final remoteDasource = CorreiosRastreioDatasource(CorreiosRastreio());
    final localDatasource = HiveDatasource();
    final deliveryRepository = DeliveryRepositoryImpl(
      remoteDasource,
      localDatasource,
    );
    final trackRepository = TrackRepositoryImpl(remoteDasource);

    final getDeliveries = GetAllDeliveriesUsecaseImpl(deliveryRepository);
    final saveDeliveries =
        SaveDeliveryUsecaseImpl(trackRepository, deliveryRepository);

    final localDeliveries = await getDeliveries();

    await localDeliveries.fold(
      (l) async => {},
      (deliveries) async {
        for (final delivery in deliveries) {
          //if (delivery.isCompleted) return;
          final request = await saveDeliveries(
            code: delivery.code,
            title: delivery.title,
            deliveryListId: delivery.deliveryListId,
          );
          await request.fold((l) async {}, (updatedDelivery) async {
            //if (delivery.events.length != updatedDelivery.events.length) {
            final lastEvent = updatedDelivery.events.first;
            await notification.showNotification(
              'Atualização no ${delivery.title.isEmpty ? delivery.code : delivery.title}',
              lastEvent.status,
            );
            //}
          });
        }
      },
    );

    BackgroundFetch.finish(taskId);
  }

  Future<void> fetchData() async {
    final localDeliveries = await getAllDeliveriesUsecase();

    await localDeliveries.fold(
      (l) async => {},
      (deliveries) async {
        for (final delivery in deliveries) {
          if (delivery.isCompleted) return;
          final request = await saveDeliveryUsecase(
            code: delivery.code,
            title: delivery.title,
            deliveryListId: delivery.deliveryListId,
          );
          await request.fold((l) async => {}, (updatedDelivery) async {
            if (delivery.events.length != updatedDelivery.events.length) {
              final lastEvent = updatedDelivery.events.first;
              await notificationService.showNotification(
                'Atualização no ${delivery.title.isEmpty ? delivery.code : delivery.title} as ${lastEvent.hora}',
                lastEvent.status,
              );
            }
          });
        }
      },
    );
  }
}
