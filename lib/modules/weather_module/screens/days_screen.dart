import 'package:flutter/material.dart';
import 'package:weather_app/modules/weather_module/widgets/daily_summary_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/detail_weather_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/frosted_glass_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/others_temp_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/rise_set_timings_widget.dart';

class DaysScreen extends StatelessWidget {
  const DaysScreen({
    super.key,
    required this.windSpeed,
    required this.windDegree,
    required this.pressure,
    required this.uvi,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
    required this.icon,
    required this.description,
    required this.summary,
    required this.clouds,
    required this.dewPoint,
    required this.windGust,
    required this.morningTemp,
    required this.dayTemp,
    required this.eveningTemp,
    required this.nightTemp,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
  });

  final String windSpeed;
  final String windDegree;
  final String pressure;
  final String uvi;
  final String humidity;
  final String tempMin;
  final String tempMax;
  final String icon;
  final String description;
  final String summary;
  final String clouds;
  final String dewPoint;
  final String windGust;

  final String morningTemp;
  final String dayTemp;
  final String eveningTemp;
  final String nightTemp;

  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FrostedGlassWidget(
              tempMin: tempMin,
              tempMax: tempMax,
              icon: icon,
              description: description,
            ),
            DailySummaryWidget(summary: summary),
            OthersTempWidget(
              morningTemp: morningTemp,
              dayTemp: dayTemp,
              eveningTemp: eveningTemp,
              nightTemp: nightTemp,
            ),
            DetailWeatherWidget(
              windSpeed: windSpeed,
              windDegree: windDegree,
              pressure: pressure,
              uvi: uvi,
              humidity: humidity,
              clouds: clouds,
              dewPoint: dewPoint,
              windGust: windGust,
            ),
            RiseSetTimingsWidget(
              sunrise: sunrise,
              sunset: sunset,
              moonrise: moonrise,
              moonset: moonset,
              moonPhase: moonPhase,
            ),
          ],
        ),
      ),
    );
  }
}
