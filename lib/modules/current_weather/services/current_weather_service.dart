import 'package:dio/dio.dart';

class CurrentWeatherService {
  String linkUrl = 'https://open-weather13.p.rapidapi.com/city/';
  var header = {
    'Accept': 'application/json',
    'X-RapidAPI-Key': 'f54dc5424fmsh61ad5f163c25f6bp1835f1jsn30763cd90d41',
  };
  Future<Response> getCurrentWeather() async {
    Response response = await Dio().get(
      '${linkUrl}phnom penh',
      options: Options(
        headers: header,
      ),
    );
    // log(response.data);
    return response;
  }
}
