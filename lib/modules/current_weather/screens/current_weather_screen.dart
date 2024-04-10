import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/modules/current_weather/stores/current_weather_store.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  CurrentWeatherStore weatherStore = CurrentWeatherStore();

  void initWeather() {
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        context.read<CurrentWeatherStore>().fetchWeatherData();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Weather'),
      ),
    );
  }
}
