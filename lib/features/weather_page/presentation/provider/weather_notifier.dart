import 'package:decagon_weather/core/usecase/usecase.dart';
import 'package:decagon_weather/features/weather_page/domain/usecases/request_device_location_usecase.dart';
import 'package:flutter/material.dart';

class WeatherNotifier extends ChangeNotifier {
  WeatherNotifier({
    
    required this.requestDeviceLocationUsecase,
  });


  final RequestDeviceLocationUsecase requestDeviceLocationUsecase;

  bool hasPermission = false;
  Future<void> requestDeviceLocation(BuildContext context) async {
    final response = await requestDeviceLocationUsecase(
      NoParams(),
    );
    response.fold(
      (l) {
        
      },
      (r) {
        hasPermission = true;
        notifyListeners();
      },
    );
  }
}
