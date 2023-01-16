import 'package:equatable/equatable.dart';

class WeatherEntities extends Equatable {
  final List<WeatherData> weather;

  final SysData sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  final MainData main;

  const WeatherEntities({
    required this.weather,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.main,
  });
  @override
  List<Object> get props => [id, cod, name, weather, sys, timezone, main];
}

class WeatherData {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherData(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  toJson() {}
}

class MainData {
  final double temp;
  
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
 
  

  const MainData(
      {required this.temp,
      
      required this.tempMin,
      required this.pressure,
      required this.humidity,
     
      
      required this.tempMax});

  toJson() {}
}

class SysData {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  const SysData(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset});
}
