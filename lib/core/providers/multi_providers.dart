import 'package:decagon_weather/core/di/di_container.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Providers extends StatelessWidget {
  final Widget child;
  const Providers({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherNotifier>(
          create: (_) => di<WeatherNotifier>(),
        ),

       // ProxyProvider<WeatherNotifier, WeatherState>(update: (context, value, previous) => WeatherState(),)
      ],
      child: child,
    );
  }
}
