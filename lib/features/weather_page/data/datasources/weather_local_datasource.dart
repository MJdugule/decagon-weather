import 'dart:convert';

import 'package:decagon_weather/core/error/exceptions.dart';
import 'package:decagon_weather/core/location/device_location.dart';
import 'package:decagon_weather/features/weather_page/data/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WeatherLocalDatasource {
  Future<Position> requestDeviceLocation();
  Future<WeatherModel> getLastWeather();
  Future<void> cacheWeather(WeatherModel wetherToCache);
}

const String cachedWeather = "cacheWeather";

@LazySingleton(as: WeatherLocalDatasource)
class WeatherLocalDatasourceImpl implements WeatherLocalDatasource {
  WeatherLocalDatasourceImpl({
    required this.sharedPreferences,
    required this.deviceLocation,
  });

  final DeviceLocation deviceLocation;
  final SharedPreferences sharedPreferences;

  @override
  Future<Position> requestDeviceLocation() async {
    return deviceLocation.getCurrentLocation();
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(cachedWeather);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel wetherToCache) {
    sharedPreferences.clear();
    return sharedPreferences.setString(
      cachedWeather,
      json.encode(wetherToCache.toJson()),
    );
  }
}
