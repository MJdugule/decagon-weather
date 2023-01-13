import 'package:decagon_weather/features/weather_page/presentation/provider/weather_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherNotifier>(builder: (context, value, child) {
        value.requestDeviceLocation(context);
        return const Center(
          child: Text("boy"),
        );
      }),
    );
  }
}
