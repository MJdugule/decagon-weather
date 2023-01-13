import 'package:decagon_weather/core/di/di_container.dart';
import 'package:decagon_weather/core/navigation/routes.dart';
import 'package:decagon_weather/core/providers/multi_providers.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const Providers(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "weather_page",
        onGenerateRoute: generateRoute);
  }
}
