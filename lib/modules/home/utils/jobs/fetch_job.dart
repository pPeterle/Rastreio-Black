import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/utils/services/notification_service.dart';

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

  _configure() {
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
  }

  Future<void> fetchData() async {
    print('buscando');
    await notificationService.showNotification(
      "Atualizando dados",
      "atualizando...",
    );
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
