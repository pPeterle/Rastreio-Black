import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    _configure();
  }

  void _configure() async {
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
