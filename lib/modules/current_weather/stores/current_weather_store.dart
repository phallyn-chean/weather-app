import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/modules/current_weather/models/currentweather_model.dart';
import 'package:weather_app/modules/current_weather/services/current_weather_service.dart';
part 'current_weather_store.g.dart';

class CurrentWeatherStore = _CurrentWeatherStoreBase with _$CurrentWeatherStore;

abstract class _CurrentWeatherStoreBase with Store {
  @observable
  CurrentWeatherModel currentWeather = CurrentWeatherModel();

  @observable
  CurrentWeatherService service = CurrentWeatherService();

  @action
  Future<void> fetchWeatherData() async {
    try {
      Response response = await service.getCurrentWeather();

      if (response.statusCode == 200) {
        print(response.data);
        currentWeather = await compute(getCurrentWeatherModel, response.data as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error on fetching weather data: ${e.toString()}');
    }
  }
}
