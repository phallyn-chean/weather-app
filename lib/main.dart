import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/constant/app_theme.dart';
import 'package:weather_app/core/helpers/notification_helper.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/location.dart';
import 'package:weather_app/modules/current_weather/screens/current_weather_screen.dart';
import 'package:weather_app/modules/current_weather/stores/current_weather_store.dart';
import 'package:weather_app/modules/push_notification/services/push_notification_helper.dart';
import 'package:weather_app/modules/weather_module/screens/weather_screen.dart';

void main() {
// Platform.isAndroid ? await
//   WidgetsFlutterBinding.ensureInitialized();
//   NotificationHelper.int();
//   NotificationHelper.init();
//   PushNotificationHelper.initialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CurrentWeatherStore(),
        )
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppThemeConstants.ligthTheme,
        darkTheme: AppThemeConstants.darkTheme,
        home: const WeatherScreens(),
      ),
    );
  }
}
