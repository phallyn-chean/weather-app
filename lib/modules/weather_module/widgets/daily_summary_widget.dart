import 'package:flutter/material.dart';

class DailySummaryWidget extends StatelessWidget {
  const DailySummaryWidget({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          summary,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
