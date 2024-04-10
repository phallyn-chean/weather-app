import 'package:flutter/material.dart';

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget({
    super.key,
    required this.asset,
    required this.value,
    required this.title,
    required this.icon,
    required this.isIcon,
  });
  final String asset;
  final String value;
  final String title;
  final Icon icon;

  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isIcon
            ? icon
            : Image.asset(
                asset,
                color: Theme.of(context).iconTheme.color,
                width: 30,
              ),
        const SizedBox(height: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
