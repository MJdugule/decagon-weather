import 'dart:convert';

import 'package:decagon_weather/core/error/exceptions.dart';
import 'package:decagon_weather/core/location/device_location.dart';
import 'package:decagon_weather/features/weather_page/data/models/five_day_model.dart';
import 'package:decagon_weather/features/weather_page/data/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WeatherLocalDatasource {
  Future<Position> requestDeviceLocation();
  Future<WeatherModel> getLastWeather();
  Future<FiveDaysWeatherModel> getLastFiveDaysWeather();
  Future<void> cacheWeather(WeatherModel wetherToCache);
  Future<void> cacheDaysWeather(FiveDaysWeatherModel daysWetherToCache);
}

const String cachedWeather = "cacheWeather";
const String cachedDaysWeather = "cacheDaysWeather";

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
  Future<FiveDaysWeatherModel> getLastFiveDaysWeather() {
    final jsonString = sharedPreferences.getString(cachedDaysWeather);
    if (jsonString != null) {
      return Future.value(FiveDaysWeatherModel.fromJson(json.decode(jsonString)));
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
  @override
  Future<void> cacheDaysWeather(FiveDaysWeatherModel daysWetherToCache) {
    sharedPreferences.clear();
    return sharedPreferences.setString(
      cachedWeather,
      json.encode(daysWetherToCache.toJson()),
    );
  }
  
 
}
