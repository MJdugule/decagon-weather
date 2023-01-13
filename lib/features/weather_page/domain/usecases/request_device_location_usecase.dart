import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/core/usecase/usecase.dart';
import 'package:decagon_weather/features/weather_page/domain/repostories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequestDeviceLocationUsecase extends UseCase<bool, NoParams> {
  RequestDeviceLocationUsecase({
    required this.weatherRepository,
  });

  final WeatherRepository weatherRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return weatherRepository.requestDeviceLocation();
  }
}
