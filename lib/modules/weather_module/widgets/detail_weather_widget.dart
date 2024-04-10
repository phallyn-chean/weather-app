import 'package:flutter/material.dart';
import 'package:weather_app/modules/weather_module/widgets/weather_detail_widget.dart';

class DetailWeatherWidget extends StatelessWidget {
  const DetailWeatherWidget({
    super.key,
    required this.windSpeed,
    required this.windDegree,
    required this.pressure,
    required this.uvi,
    required this.humidity,
    required this.clouds,
    required this.dewPoint,
    required this.windGust,
  });

  final String windSpeed;
  final String windDegree;
  final String pressure;
  final String uvi;
  final String humidity;
  final String clouds;
  final String dewPoint;
  final String windGust;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailWidget(
                asset: "assets/icons/windspeed.png",
                value: windSpeed,
                title: "Wind Speed",
                icon: const Icon(Icons.add),
                isIcon: false,
              ),
              WeatherDetailWidget(
                asset: "assets/icons/winddegree.png",
                value: windDegree,
                title: "Wind Degree",
                icon: const Icon(Icons.add),
                isIcon: false,
              ),
              WeatherDetailWidget(
                asset: "assets/icons/pressure.png",
                value: pressure,
                title: "Pressure",
                icon: const Icon(Icons.add),
                isIcon: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailWidget(
                asset: "",
                value: uvi,
                title: "UV Index",
                icon: const Icon(Icons.sunny),
                isIcon: true,
              ),
              WeatherDetailWidget(
                asset: "assets/icons/humidity.png",
                value: humidity,
                title: "Humidity",
                icon: const Icon(Icons.add),
                isIcon: false,
              ),
              WeatherDetailWidget(
                asset: "assets/icons/clouds.png",
                value: clouds,
                title: "Clouds",
                icon: const Icon(Icons.add),
                isIcon: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailWidget(
                asset: "",
                value: dewPoint,
                title: "Dew Point",
                icon: const Icon(Icons.dew_point),
                isIcon: true,
              ),
              WeatherDetailWidget(
                asset: "",
                value: windGust,
                title: "Wind Gust",
                icon: const Icon(Icons.wind_power_outlined),
                isIcon: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
