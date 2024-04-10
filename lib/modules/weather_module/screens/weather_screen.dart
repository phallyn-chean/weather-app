import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/services/api_service.dart';
import 'package:weather_app/core/widgets/tabs_widget.dart';
import 'package:weather_app/modules/weather_module/models/weather_model.dart';
import 'package:weather_app/modules/weather_module/screens/day_to_day_screen.dart';
import 'package:weather_app/modules/weather_module/screens/days_screen.dart';
import 'package:weather_app/modules/weather_module/services/weather_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/modules/weather_module/widgets/loader_widget.dart';

class WeatherScreens extends StatefulWidget {
  const WeatherScreens({super.key});

  @override
  State<WeatherScreens> createState() => _WeatherScreensState();
}

class _WeatherScreensState extends State<WeatherScreens> {
  String location = 'Your Location';
  String? error;

  double lat = 0.0;
  double lon = 0.0;

  List dates = [];
  List days = [];

  List<String> hourlyTime = [];
  List<String> hourlyTemp = [];
  List<String> hourlyIcon = [];

  bool isLoading = true;
  bool isError = false;

  WeatherModel? weatherModel;

  @override
  void initState() {
    super.initState();
    weatherModel = WeatherModel();
    getCurrentLocation();
    // WeatherService().getWeatherData(weatherModel!, lat, lon, days, dates, hourlyTime, hourlyTemp, hourlyIcon);
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      setState(() {
        isError = true;
        error = "Location services are disable & then restart the application";
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      lat = value.latitude;
      lon = value.longitude;
      print("Latitude: $lat");
      print("Longtitude: $lon");
      getCityName();
      getWeatherData();
      return value;
    });
  }

  Future getWeatherData() async {
    try {
      final response = await Dio().get(ApiService().apiUrl(lat, lon));
      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data); // Convert the map object to a string
        var jsonData = jsonDecode(jsonString); // Decode the string to a map object
        weatherModel = WeatherModel(
          current: WeatherModelCurrent.fromJson(jsonData),
          daily: WeatherModelDaily.fromJson(jsonData),
          hourly: WeatherModelHourly.fromJson(jsonData),
        );

        getDaysAndDates();
        getHourlyTime();
        getHourData();
        setState(() {
          isLoading = false;
        });
        return weatherModel;
      } else {
        return "Error";
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getCityName() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    Placemark placemark = placemarks[0];

    setState(() {
      location = "${placemark.subLocality}";
    });
  }

  void getDaysAndDates() {
    for (int i = 0; i < weatherModel!.getDailyWeather()!.daily.length; i++) {
      getDay(weatherModel?.getDailyWeather()?.daily[i].dt);
      getDate(weatherModel?.getDailyWeather()?.daily[i].dt);
    }
  }

  void getHourlyTime() {
    for (int i = 0; i < weatherModel!.getHourlyWeather()!.hourly.length; i++) {
      getHours(weatherModel?.getHourlyWeather()?.hourly[i].dt);
    }
  }

  void getHourData() {
    for (int i = 0; i < weatherModel!.getHourlyWeather()!.hourly.length; i++) {
      hourlyTemp.add(weatherModel?.getHourlyWeather()?.hourly[i].temp!.round().toString() ?? "");
      hourlyIcon.add(weatherModel?.getHourlyWeather()?.hourly[i].weather![0].icon.toString() ?? "");
    }
  }

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final dayName = DateFormat('EEEE').format(time);
    days.add(dayName);
    return dayName;
  }

  String getDate(final day) {
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

  void getHours(final day) {
    hourlyTime.add(getTime(day));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoaderWidget(error: error, isError: isError)
        : DefaultTabController(
            length: 8,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  location,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                actions: [
                  IconButton(
                    onPressed: () {
                      _bottomSheet();
                    },
                    icon: Icon(
                      Icons.map_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  automaticIndicatorColorAdjustment: true,
                  indicator: Theme.of(context).tabBarTheme.indicator,
                  tabs: [
                    TabsWidget(day: "Today", date: dates[0]),
                    TabsWidget(day: "Tomorrow", date: dates[1]),
                    TabsWidget(day: days[2], date: dates[2]),
                    TabsWidget(day: days[3], date: dates[3]),
                    TabsWidget(day: days[4], date: dates[4]),
                    TabsWidget(day: days[5], date: dates[5]),
                    TabsWidget(day: days[6], date: dates[6]),
                    TabsWidget(day: days[7], date: dates[7]),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        DayToDayScreen(
                          temp: NumberFormat('0.00').format((weatherModel?.getCurrentWeather()?.current.temp?.round() ?? 0) - 273.15),
                          tempMax: "${weatherModel?.getDailyWeather()?.daily[0].temp?.max?.round().toString()}",
                          tempMin: "${weatherModel?.getDailyWeather()?.daily[0].temp?.min?.round().toString()}",
                          icon: weatherModel?.getCurrentWeather()?.current.weather![0].icon.toString() ?? "",
                          description: weatherModel?.getCurrentWeather()?.current.weather![0].main.toString() ?? "",
                          summary: "${weatherModel?.getDailyWeather()?.daily[0].summary}",
                          morningTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[0].temp?.morn?.round() ?? 0) - 273.15),
                          dayTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[0].temp?.day?.round() ?? 0) - 273.15),
                          eveningTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[0].temp?.eve?.round() ?? 0) - 273.15),
                          nightTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[0].temp?.night?.round() ?? 0) - 273.15),
                          windSpeed: '${weatherModel?.getCurrentWeather()?.current.windSpeed.toString() ?? ""} m/s',
                          windDegree: '${weatherModel?.getCurrentWeather()?.current.windDeg.toString()}°',
                          pressure: '${weatherModel?.getCurrentWeather()?.current.pressure.toString()} hPa',
                          uvi: weatherModel?.getCurrentWeather()?.current.uvi.toString() ?? "",
                          humidity: '${weatherModel?.getCurrentWeather()?.current.humidity.toString()}%',
                          visibility: '${weatherModel?.getCurrentWeather()?.current.visibility.toString()} KM',
                          clouds: '${weatherModel?.getCurrentWeather()?.current.clouds.toString()}%',
                          dewPoint: '${weatherModel?.getCurrentWeather()?.current.dewPoint.toString()}°',
                          windGust: '${weatherModel?.getCurrentWeather()?.current.windGust.toString()} m/s',
                          lenght: weatherModel?.getHourlyWeather()?.hourly.length ?? 0,
                          hourlyList: hourlyTime,
                          hourlyIconList: hourlyIcon,
                          hourlyTempList: hourlyTemp,
                          sunrise: getTime(weatherModel?.getDailyWeather()?.daily[0].sunrise),
                          sunset: getTime(weatherModel?.getDailyWeather()?.daily[0].sunset),
                          moonset: getTime(weatherModel?.getDailyWeather()?.daily[0].moonset),
                          moonrise: getTime(weatherModel?.getDailyWeather()?.daily[0].moonrise),
                          moonPhase: weatherModel?.getDailyWeather()?.daily[0].moonPhase.toString() ?? "",
                        ),
                        _builddays(index: 1),
                        _builddays(index: 2),
                        _builddays(index: 3),
                        _builddays(index: 4),
                        _builddays(index: 5),
                        _builddays(index: 6),
                        _builddays(index: 7)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _builddays({required int index}) {
    return DaysScreen(
      tempMin: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[index].temp?.min?.round() ?? 0) - 273.15),
      tempMax: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[index].temp?.max?.round() ?? 0) - 273.15),
      icon: weatherModel?.getDailyWeather()?.daily[index].weather![0].icon?.toString() ?? "",
      description: weatherModel?.getDailyWeather()?.daily[index].weather![0].description.toString() ?? "",
      summary: "${weatherModel?.getDailyWeather()?.daily[index].summary}",
      morningTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[index].temp?.morn?.round() ?? 0) - 273.15),
      dayTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[index].temp?.day?.round() ?? 0) - 273.15),
      eveningTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[index].temp?.eve?.round() ?? 0) - 273.15),
      nightTemp: NumberFormat('0.00').format((weatherModel?.getDailyWeather()?.daily[index].temp?.night?.round() ?? 0) - 273.15),
      windSpeed: '${weatherModel?.getDailyWeather()?.daily[index].temp?.max?.round().toString()} m/s',
      windDegree: '${weatherModel?.getDailyWeather()?.daily[index].windDeg.toString()}°',
      pressure: '${weatherModel?.getDailyWeather()?.daily[index].pressure.toString()} hPa',
      uvi: weatherModel?.getDailyWeather()?.daily[index].uvi.toString() ?? "",
      humidity: '${weatherModel?.getDailyWeather()?.daily[index].humidity.toString()}%',
      clouds: '${weatherModel?.getDailyWeather()?.daily[index].clouds.toString()}%',
      dewPoint: '${weatherModel?.getDailyWeather()?.daily[index].dewPoint.toString()}°',
      windGust: '${weatherModel?.getDailyWeather()?.daily[index].windGust.toString()} m/s',
      sunrise: getTime(weatherModel?.getDailyWeather()?.daily[index].sunrise),
      sunset: getTime(weatherModel?.getDailyWeather()?.daily[index].sunset),
      moonrise: getTime(weatherModel?.getDailyWeather()?.daily[index].moonrise),
      moonset: getTime(weatherModel?.getDailyWeather()?.daily[index].moonset),
      moonPhase: weatherModel?.getDailyWeather()?.daily[index].moonPhase.toString() ?? "",
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - 200,
      ),
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.97,
          minChildSize: 0.97,
          maxChildSize: 0.97,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                controller: controller,
                children: [
                  Text(
                    "Weather Legend",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  DataTable(dataRowMaxHeight: 70, columns: [
                    DataColumn(
                      label: Text(
                        "Detail",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    )
                  ], rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Text("Wind Speed", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                        ),
                        DataCell(
                          Text("Speed of wind, m/s", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                        )
                      ],
                    ),
                    DataRow(cells: [
                      DataCell(
                        Text("Wind Degree", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("Wind direction, degree (meteorological).", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text("Pressure", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("Atmosperic pressure on the sea level, hPa", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text("UV Index", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("The intensity of UV from sun, varies from 0 to 11+.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text("Humidity", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("Humidity, %", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text("Visibility", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("Average visibility, metres. The maximum value of the visibility is 10 km.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text("Clouds", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("Cloudiness, %", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text("Dew Point", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("Temperature below which water droplets form a dew.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text("Wind Gust", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      ),
                      DataCell(
                        Text("A wind gust is a sudden burst of high-speed wind.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                      )
                    ])
                  ])
                ],
              ),
            );
          },
        );
      },
    );
  }
}
