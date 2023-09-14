// ignore_for_file: avoid_print
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificaitonResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return _flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
    required DateTime scheduleNotificationDatetime,
  }) async {
    print('Scheduled datetime: $scheduleNotificationDatetime');

    if (scheduleNotificationDatetime.isBefore(DateTime.now())) {
      print('Scheduled datetime is in the past.');
      return;
    }

    return _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduleNotificationDatetime,
        tz.local,
      ),
      await notificationDetails(),
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
