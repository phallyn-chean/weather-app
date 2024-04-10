import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static int() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  static init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    tz.initializeTimeZones();
  }

  static scheduledNotification(String title, String body) async {
    tz.initializeTimeZones();
    var androidDetails = const AndroidNotificationDetails(
      'important_notification',
      'My Chanel',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosDetails = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notification.zonedSchedule(
      100,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(
        const Duration(seconds: 10),
      ),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static pushNotification({required String title, required String body}) async {
    var androidDetails = const AndroidNotificationDetails(
      'important_channel',
      'My Chanel',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosDetail = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetail);
    await _notification.show(100, title, body, notificationDetails);
  }
}
