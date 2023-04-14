import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final GetAllDeliveriesUsecaseImpl getAllDeliveriesUsecaseImpl;

  NotificationService(this.getAllDeliveriesUsecaseImpl) {
    _configure();
  }

  void _configure() async {
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      final result = await getAllDeliveriesUsecaseImpl();
      result.fold(
        id,
        (deliveries) {
          final delivery = deliveries.firstWhere(
            (delivery) =>
                delivery.id ==
                notificationAppLaunchDetails.notificationResponse!.id,
          );
          Modular.to.pushNamed(
            '/delivery',
            arguments: delivery,
          );
        },
      );
    }

    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  Future<void> showNotification(
    int id,
    String title,
    String message,
  ) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'RastreioBlackNotificacao',
      'Atualização na Encomenda',
      channelDescription:
          'Notificação para quando houver atualização na sua encomenda',
      icon: 'ic_notification',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      message,
      notificationDetails,
    );
  }
}
