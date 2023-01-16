import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/core/usecase/usecase.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/five_days_entities.dart';
import 'package:decagon_weather/features/weather_page/domain/usecases/get_five_days_usecase.dart';
import 'package:decagon_weather/features/weather_page/domain/usecases/request_device_location_usecase.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_event.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_state.dart';
import 'package:flutter/material.dart';

class FiveDayWeatherNotifier extends ChangeNotifier {
  FiveDayWeatherNotifier({
    required this.requestDeviceLocationUsecase,
    required this.fiveDaysWeatherUsecase,
  });

  final RequestDeviceLocationUsecase requestDeviceLocationUsecase;

  final FiveDaysWeatherUsecase fiveDaysWeatherUsecase;

  bool hasPermission = false;
  bool location = false;
  WeatherState state = Empty();
  FiveDaysEntities? fiveDaysEntities;
  Future<void> requestDeviceLocation(BuildContext context) async {
    final response = await requestDeviceLocationUsecase(
      NoParams(),
    );
    response.fold(
      (l) {
        state = Empty();
        hasPermission = false;
      },
      (r) async {
        state = Loading();

        final fiveFailureOrWeather = await fiveDaysWeatherUsecase(
            Params(lat: r.latitude.toString(), lon: r.longitude.toString()));
        fiveFailureOrWeather.fold((l) {}, (r) {
          fiveDaysEntities = r;
          LoadedFiveDay(fiveDayWeatherEntities: fiveDaysEntities!);
          state = LoadedFiveDay(fiveDayWeatherEntities: fiveDaysEntities!);
        });

        hasPermission = true;
        notifyListeners();
      },
    );
  }

  Stream eitherLoadedOrErrorState(
    Either<Failure, FiveDaysEntities> failureOrWeather,
  ) async* {
    yield failureOrWeather.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (weather) {
        fiveDaysEntities = weather;
      },
    );
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "SERVER_FAILURE_MESSAGE";
      case CacheFailure:
        return "CACHE_FAILURE_MESSAGE";
      default:
        return 'Unexpected error';
    }
  }

  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield Loading();
    // final failureOrWeather = await currentWeather(Params(lat: , lon: ));
    // yield* _eitherLoadedOrErrorState(failureOrWeather);
    notifyListeners();
  }
}
