import 'package:flutter/material.dart';
import 'package:weather_app/core/constant/pallete_constants.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key, this.error, required this.isError});
  final String? error;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icons/clouds.png',
            width: 100,
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            color: PalleteLight.iconColor,
          ),
          const SizedBox(height: 20),
          isError
              ? Text(
                  error!,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
