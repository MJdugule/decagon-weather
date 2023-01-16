import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Position>> requestDeviceLocation();
  Future<Either<Failure, WeatherEntities>> getCurrentWeather({
    required String lat,
    required String lon,
  });
}
