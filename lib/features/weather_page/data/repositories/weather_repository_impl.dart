import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/features/weather_page/data/datasources/weather_local_datasource.dart';
import 'package:decagon_weather/features/weather_page/domain/repostories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required this.weatherLocalDatasource,
  });

  final WeatherLocalDatasource weatherLocalDatasource;

  @override
  Future<Either<Failure, bool>> requestDeviceLocation() async {
    try {
      final response = await weatherLocalDatasource.requestDeviceLocation();
      return Right(response);
    } catch (e) {
      return Left(
        ServerFailure(),
      );
    }
  }
}
