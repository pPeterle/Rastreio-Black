import 'package:background_fetch/background_fetch.dart';
import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/utils/services/notification_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

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
          minimumFetchInterval: 75,
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
    print('[BackgroundFetch] Headless event received.');
    bool isTimeout = task.timeout;
    if (isTimeout) {
      BackgroundFetch.finish(taskId);
      return;
    }

    try {
      await Hive.initFlutter();

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

      final notification = NotificationService(getDeliveries);
      final localDeliveries = await getDeliveries();

      await localDeliveries.fold(
        (l) async => {},
        (deliveries) async {
          for (final delivery in deliveries) {
            print(
              '[BackgroundFetch] delivery codigo: ${delivery.code} finalizado: ${delivery.isCompleted} evento: ${delivery.events.first.data}',
            );
            if (delivery.isCompleted) continue;
            final request = await saveDeliveries(
              code: delivery.code,
              title: delivery.title,
              deliveryListId: delivery.deliveryListId,
            );
            await request.fold((l) async {}, (updatedDelivery) async {
              print(
                '[BackgroundFetch] delivery atualizado codigo: ${updatedDelivery.code} finalizado: ${updatedDelivery.isCompleted} quantidade eventos: ${updatedDelivery.events.length} evento: ${updatedDelivery.events.first.data}',
              );
              if (delivery.events.length != updatedDelivery.events.length) {
                final lastEvent = updatedDelivery.events.first;
                print('[BackgroundFetch] enviando notificacao.');
                await notification.showNotification(
                  updatedDelivery.id,
                  'Atualização no ${delivery.title.isEmpty ? delivery.code : delivery.title}',
                  lastEvent.status,
                );
              }
            });
          }
        },
      );
    } catch (e) {
      print('[BackgroundFetch] algum erro aocnteceu');
      print('[BackgroundFetch] ${e.toString()}');
    }

    BackgroundFetch.finish(taskId);
  }

  Future<void> fetchData() async {
    print('[BackgroundFetch] event received.');
    final localDeliveries = await getAllDeliveriesUsecase();

    await localDeliveries.fold(
      (l) async => {},
      (deliveries) async {
        for (final delivery in deliveries) {
          print(
            '[BackgroundFetch] delivery codigo: ${delivery.code} finalizado: ${delivery.isCompleted} evento: ${delivery.events.first.data}',
          );
          if (delivery.isCompleted) continue;
          final request = await saveDeliveryUsecase(
            code: delivery.code,
            title: delivery.title,
            deliveryListId: delivery.deliveryListId,
          );
          await request.fold((l) async => {}, (updatedDelivery) async {
            print(
              '[BackgroundFetch] delivery atualizado codigo: ${updatedDelivery.code} finalizado: ${updatedDelivery.isCompleted} quantidade eventos: ${updatedDelivery.events.length} evento: ${updatedDelivery.events.first.data}',
            );
            if (delivery.events.length != updatedDelivery.events.length) {
              final lastEvent = updatedDelivery.events.first;
              final dateFormat = DateFormat("HH:mm");
              await notificationService.showNotification(
                updatedDelivery.id,
                'Atualização no ${delivery.title.isEmpty ? delivery.code : delivery.title} as ${dateFormat.format(lastEvent.data)}',
                lastEvent.status,
              );
            }
          });
        }
      },
    );
  }
}
