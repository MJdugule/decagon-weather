import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/core/usecase/usecase.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:decagon_weather/features/weather_page/domain/repostories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrentWeatherUsecase extends UseCase<WeatherEntities, Params> {
  CurrentWeatherUsecase({
    required this.weatherRepository,
  });

  final WeatherRepository weatherRepository;

  @override
  Future<Either<Failure, WeatherEntities>> call(Params params) async {
    return weatherRepository.getCurrentWeather(lat: params.lat, lon: params.lon);
  }
}

