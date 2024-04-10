import 'package:flutter/material.dart';
import 'package:weather_app/modules/weather_module/widgets/daily_summary_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/frosted_glass_current.dart';
import 'package:weather_app/modules/weather_module/widgets/hourly_weather_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/others_temp_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/rise_set_timings_widget.dart';
import 'package:weather_app/modules/weather_module/widgets/weather_detail_current_widget.dart';

class DayToDayScreen extends StatelessWidget {
  const DayToDayScreen({
    super.key,
    required this.windSpeed,
    required this.windDegree,
    required this.pressure,
    required this.uvi,
    required this.humidity,
    required this.visibility,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
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
    required this.lenght,
    required this.hourlyList,
    required this.hourlyIconList,
    required this.hourlyTempList,
    required this.sunrise,
    required this.sunset,
    required this.moonset,
    required this.moonrise,
    required this.moonPhase,
  });

  final String windSpeed;
  final String windDegree;
  final String pressure;
  final String uvi;
  final String humidity;
  final String visibility;
  final String temp;
  final String tempMax;
  final String tempMin;
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

  final int lenght;

  final List<String> hourlyList;
  final List<String> hourlyIconList;
  final List<String> hourlyTempList;

  final String sunrise;
  final String sunset;
  final String moonset;
  final String moonrise;
  final String moonPhase;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FrostedGlassCurrentWidget(
              temp: temp,
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
            WeatherDetailCurrentWidget(
              windSpeed: windSpeed,
              windDegree: windDegree,
              pressure: pressure,
              uvi: uvi,
              humidity: humidity,
              visibility: visibility,
              clouds: clouds,
              dewPoint: dewPoint,
              windGust: windGust,
            ),
            HourlyWeatherWidget(
              lenght: lenght,
              hourlyList: hourlyList,
              hourlyIconList: hourlyIconList,
              hourlyTempList: hourlyTempList,
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
