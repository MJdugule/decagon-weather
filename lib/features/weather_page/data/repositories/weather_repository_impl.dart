import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/exceptions.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/core/network/network_info.dart';
import 'package:decagon_weather/features/weather_page/data/datasources/weather_local_datasource.dart';
import 'package:decagon_weather/features/weather_page/data/datasources/weather_remote_datasource.dart';
import 'package:decagon_weather/features/weather_page/data/models/five_day_model.dart';
import 'package:decagon_weather/features/weather_page/data/models/weather_model.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/five_days_entities.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:decagon_weather/features/weather_page/domain/repostories/weather_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required this.networkInfo,
    required this.weatherLocalDatasource,
    required this.weatherRemoteDatasource,
  });

  final WeatherLocalDatasource weatherLocalDatasource;
  final WeatherRemoteDataSource weatherRemoteDatasource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Position>> requestDeviceLocation() async {
    try {
      final response = await weatherLocalDatasource.requestDeviceLocation();

      return Right(response);
    } catch (e) {
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, WeatherEntities>> getCurrentWeather(
      {required String lat, required String lon}) async {
    return await _getWether(
        weatherRemoteDatasource.getCurrentWeather(lat: lat, lon: lon));
  }

  @override
  Future<Either<Failure, FiveDaysEntities>> getFiveDaysWeather(
      {required String lat, required String lon}) async {
    return await _getDaysWether(
        weatherRemoteDatasource.getFiveDaysWeather(lat: lat, lon: lon));
  }

  Future<Either<Failure, WeatherEntities>> _getWether(
      Future<WeatherModel> param0) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await param0;
        weatherLocalDatasource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await weatherLocalDatasource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, FiveDaysEntities>> _getDaysWether(
      Future<FiveDaysWeatherModel> param1) async {
    if (await networkInfo.isConnected) {
      try {
        final remotesWeather = await param1;
        weatherLocalDatasource.cacheDaysWeather(remotesWeather);
        return Right(remotesWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localsWeather = await weatherLocalDatasource.getLastFiveDaysWeather();
        return Right(localsWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
