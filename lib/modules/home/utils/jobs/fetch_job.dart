import 'package:background_fetch/background_fetch.dart';
import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/correios_rastreio_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/hive_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/delivery_repository_impl.dart';
import 'package:flutter_clean_architeture/modules/home/utils/services/notification_service.dart';
import 'package:hive_flutter/adapters.dart';

import '../../infra/models/delivery_event_model.dart';
import '../../infra/models/delivery_model.dart';

class FetchJob {
  final GetAllDeliveriesUsecase getAllDeliveriesUsecase;
  final SaveDeliveryUsecase saveDeliveryUsecase;
  final NotificationService notificationService;

  FetchJob(
    this.getAllDeliveriesUsecase,
    this.saveDeliveryUsecase,
    this.notificationService,
  ) {
    _configure();
  }

  _configure() async {
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
    Hive.registerAdapter(DeliveryEventModelAdapter());
    Hive.registerAdapter(DeliveryModelAdapter());
    await Hive.openBox<DeliveryModel>(HiveDatasource.deliveryBoxKey);

    final notification = NotificationService();
    final repository = DeliveryRepositoryImpl(
      CorreiosRastreioDatasource(CorreiosRastreio()),
      HiveDatasource(),
    );
    final getDeliveries = GetAllDeliveriesUsecaseImpl(repository);
    final saveDeliveries = SaveDeliveryUsecaseImpl(repository);

    final localDeliveries = await getDeliveries();

    await localDeliveries.fold(
      (l) async => {},
      (deliveries) async {
        for (final delivery in deliveries) {
          final request = await saveDeliveries(
            delivery.code,
            title: delivery.title,
          );
          request.fold((l) async => {}, (updatedDelivery) async {
            if (delivery.events.length != updatedDelivery.events.length) {
              final lastEvent = updatedDelivery.events.first;
              await notification.showNotification(
                'Atualização no ${delivery.title.isEmpty ? delivery.code : delivery.title}',
                lastEvent.status,
              );
            }
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
          final request = await saveDeliveryUsecase(
            delivery.code,
            title: delivery.title,
          );
          request.fold((l) async => {}, (updatedDelivery) async {
            if (delivery.events.length != updatedDelivery.events.length) {
              final lastEvent = updatedDelivery.events.last;
              await notificationService.showNotification(
                'Atualização no ${delivery.title.isEmpty ? delivery.code : delivery.title} as ${lastEvent.hora}',
                "Local: ${lastEvent.local} e Status: ${lastEvent.status}",
              );
            }
          });
        }
      },
    );
  }
}
