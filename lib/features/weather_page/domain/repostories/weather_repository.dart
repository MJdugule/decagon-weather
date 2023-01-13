import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';

abstract class WeatherRepository {
  Future<Either<Failure, bool>> requestDeviceLocation();
}
