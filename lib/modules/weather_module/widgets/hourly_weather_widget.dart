import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({
    super.key,
    required this.lenght,
    required this.hourlyList,
    required this.hourlyIconList,
    required this.hourlyTempList,
  });

  final int lenght;

  final List<String> hourlyList;
  final List<String> hourlyIconList;
  final List<String> hourlyTempList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lenght,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondary,
            ),
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  hourlyList[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                Image.asset("assets/weathers/${hourlyIconList[index]}.png", width: 30),
                const SizedBox(height: 5),
                Text(
                  "${NumberFormat('0.00').format(double.parse(hourlyTempList[index]) - 273.15)}°",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
