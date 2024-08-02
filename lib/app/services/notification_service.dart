import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationsResponse) async {});
  }

  NotificationDetails notificationDetails(String channelId) {
    return NotificationDetails(
        android: AndroidNotificationDetails(channelId, 'channel_name', playSound : true,  sound: RawResourceAndroidNotificationSound('lagu2'),
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payLoad, required String sound, required String channelId, required tz.TZDateTime scheduledTime}) async {
    return notificationsPlugin.zonedSchedule(
        id, title, body, scheduledTime, await notificationDetails(channelId),
        payload: payLoad,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
}
