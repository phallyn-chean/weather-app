import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/services/api_service.dart';
import 'package:weather_app/modules/weather_module/models/weather_model.dart';

class WeatherService {
  Future<void> getWeatherData(
    WeatherModel weather,
    double lat,
    double lon,
    List days,
    List dates,
    List<String> hourlyTime,
    List<String> hourlyTemp,
    List<String> hourlyIcon,
  ) async {
    try {
      final response = await Dio().get(ApiService().apiUrl(11.594538, 104.9279495));
      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data); // Convert the map object to a string
        var jsonData = jsonDecode(jsonString); // Decode the string to a map object
        weather = WeatherModel(
          current: WeatherModelCurrent.fromJson(jsonData),
          daily: WeatherModelDaily.fromJson(jsonData),
          hourly: WeatherModelHourly.fromJson(jsonData),
        );

        getDaysAndDates(weather, days, dates);
        getHourlyTime(weather, hourlyTime);
        getHourData(weather, hourlyTemp, hourlyIcon);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getDaysAndDates(WeatherModel? weatherModel, List days, List dates) {
    for (int i = 0; i < weatherModel!.getDailyWeather()!.daily.length; i++) {
      getDay(weatherModel.getDailyWeather()?.daily[i].dt, days);
      getDate(weatherModel.getDailyWeather()?.daily[i].dt, dates);
    }
  }

  void getHourlyTime(WeatherModel? weatherModel, List<String> hourlyTime) {
    for (int i = 0; i < weatherModel!.getHourlyWeather()!.hourly.length; i++) {
      getHours(weatherModel.getHourlyWeather()?.hourly[i].dt, hourlyTime);
    }
  }

  void getHourData(WeatherModel? weatherModel, List<String> hourlyTemp, List<String> hourlyIcon) {
    for (int i = 0; i < weatherModel!.getHourlyWeather()!.hourly.length; i++) {
      hourlyTemp.add(weatherModel.getHourlyWeather()?.hourly[i].temp!.round().toString() ?? "");
      hourlyIcon.add(weatherModel.getHourlyWeather()?.hourly[i].weather![0].icon.toString() ?? "");
    }
  }

  String getDay(final day, List days) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final dayName = DateFormat('EEEE').format(time);
    days.add(dayName);
    return dayName;
  }

  String getDate(final day, List dates) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final date = DateFormat('dd/MM').format(time);
    dates.add(date);
    return date;
  }

  getTime(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final hourTime = DateFormat('jm').format(time);

    return hourTime;
  }

  void getHours(final day, List<String> hourlyTime) {
    hourlyTime.add(getTime(day));
  }
}
