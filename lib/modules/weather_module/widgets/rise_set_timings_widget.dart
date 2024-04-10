import 'package:flutter/material.dart';
import 'package:weather_app/modules/weather_module/widgets/weather_detail_widget.dart';

class RiseSetTimingsWidget extends StatelessWidget {
  const RiseSetTimingsWidget({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
  });

  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailWidget(
                asset: "assets/icons/sunrise.png",
                value: sunrise,
                title: "Sunrise",
                icon: const Icon(Icons.co2),
                isIcon: false,
              ),
              WeatherDetailWidget(
                asset: "assets/icons/sunset.png",
                value: sunset,
                title: "Sunset",
                icon: const Icon(Icons.co2),
                isIcon: false,
              ),
              WeatherDetailWidget(
                asset: "assets/icons/moonrise.png",
                value: moonrise,
                title: "Moonrise",
                icon: const Icon(Icons.co2),
                isIcon: false,
              ),
              WeatherDetailWidget(
                asset: "assets/icons/moonset.png",
                value: moonset,
                title: "Moonset",
                icon: const Icon(Icons.co2),
                isIcon: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
