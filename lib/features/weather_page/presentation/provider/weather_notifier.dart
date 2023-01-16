import 'package:dartz/dartz.dart';
import 'package:decagon_weather/core/error/failures.dart';
import 'package:decagon_weather/core/usecase/usecase.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:decagon_weather/features/weather_page/domain/usecases/get_current_weather.dart';
import 'package:decagon_weather/features/weather_page/domain/usecases/request_device_location_usecase.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_event.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_state.dart';
import 'package:flutter/material.dart';

class WeatherNotifier extends ChangeNotifier {
  WeatherNotifier({
    required this.requestDeviceLocationUsecase,
    required this.currentWeather,
  });

  final RequestDeviceLocationUsecase requestDeviceLocationUsecase;
  final CurrentWeatherUsecase currentWeather;


  bool hasPermission = false;
  bool location = false;
  WeatherState state = Empty();
  WeatherEntities? entities;
  Future<void> requestDeviceLocation(BuildContext context) async {
    final response = await requestDeviceLocationUsecase(
      NoParams(),
    );
    response.fold(
      (l) {
        state = Empty();
        hasPermission = false;
      },
      (r)async {
       state = Loading();
       final failureOrWeather = await currentWeather(Params(lat: r.latitude.toString(), lon: r.longitude.toString() ));
      failureOrWeather.fold((l) {
        
      },
      (r){
        entities = r;
        Loaded(weatherEntities: entities!);
       state = Loaded(weatherEntities: entities!);
      }
      );
     eitherLoadedOrErrorState(failureOrWeather);
     
        hasPermission = true;
        notifyListeners();
      },
    );
  }

  Stream eitherLoadedOrErrorState(
    Either<Failure, WeatherEntities> failureOrWeather,
  ) async* {
    
    yield failureOrWeather.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (weather) {
        entities = weather;
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
