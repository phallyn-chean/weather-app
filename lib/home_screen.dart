import 'package:flutter/material.dart';
import 'package:weather_app/core/helpers/notification_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                NotificationHelper.pushNotification(
                  title: 'this is title',
                  body: 'this is a body of notification',
                );
              },
              child: const Text('Send Notification'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                NotificationHelper.scheduledNotification(
                  'this is Schedule',
                  'this is a Schedule of notification',
                );
              },
              child: const Text('Send Notification Schedule'),
            ),
          ),
        ],
      ),
    );
  }
}
