import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification?.title ?? "");
}

class PushNotificationHelper {
  static String fcmToken = "";

  static Future<void> initialized() async {
    await Firebase.initializeApp();

    if (Platform.isAndroid) {
      NotificationHelpers.initialized();
    } else if (Platform.isIOS) {}

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    getDeviceTokenToSendNotification();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");

      if (message != null) {
        print("New Notification");
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");

      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);

        NotificationHelpers.displayNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");

      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);
      }
    });
  }

  static Future<void> getDeviceTokenToSendNotification() async {
    fcmToken = await FirebaseMessaging.instance.getToken().toString();
    print(fcmToken);
  }
}

class NotificationHelpers {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialized() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
      onDidReceiveNotificationResponse: (details) {},
      onDidReceiveBackgroundNotificationResponse: localBackgroundHandler,
    );
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().microsecondsSinceEpoch ~/ 1000;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "weather_app",
          "weather_app_channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'] ?? "",
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

Future<void> localBackgroundHandler(NotificationResponse data) async {
  print(data.toString());
}
