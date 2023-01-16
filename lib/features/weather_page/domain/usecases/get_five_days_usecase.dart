import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/core/usecase/usecase.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/five_days_entities.dart';
import 'package:decagon_weather/features/weather_page/domain/repostories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FiveDaysWeatherUsecase extends UseCase<FiveDaysEntities, Params> {
  FiveDaysWeatherUsecase({
    required this.weatherRepository,
  });

  final WeatherRepository weatherRepository;

  @override
  Future<Either<Failure, FiveDaysEntities>> call(Params params) async {
    return weatherRepository.getFiveDaysWeather(
        lat: params.lat, lon: params.lon);
  }
}
