import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({super.key, required this.day, required this.date});

  final String day;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          Text(
            day,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
