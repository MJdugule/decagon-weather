import 'package:equatable/equatable.dart';

class FiveDaysEntities extends Equatable {
  final List<ListData> list;

  

  const FiveDaysEntities({
    required this.list,
    
  });
  @override
  List<Object> get props => [list];
}

class ListData {
  final List<WeatherData>? weather;
  
  const ListData(
      {required this.weather,
      
      });

  toJson() {}
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
