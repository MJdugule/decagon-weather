import 'package:decagon_weather/features/weather_page/domain/entities/five_days_entities.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends WeatherState {}

class Loading extends WeatherState {}

class Loaded extends WeatherState {
  final WeatherEntities weatherEntities;

  Loaded({required this.weatherEntities});

  @override
  List<Object> get props => [weatherEntities];
}
class LoadedFiveDay extends WeatherState {
  final FiveDaysEntities fiveDayWeatherEntities;

  LoadedFiveDay({required this.fiveDayWeatherEntities});

  @override
  List<Object> get props => [fiveDayWeatherEntities];
}

class Error extends WeatherState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
