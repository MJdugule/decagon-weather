import 'package:decagon_weather/features/weather_page/domain/entities/five_days_entities.dart';

class FiveDaysWeatherModel extends FiveDaysEntities {
  const FiveDaysWeatherModel({required List<Lists> list})
      : super(list: list);

  factory FiveDaysWeatherModel.fromJson(Map<String, dynamic> json) {
    return FiveDaysWeatherModel(
        list: (json['list'] as List<dynamic>?)!
            .map((e) => Lists.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['list'] = list.map((v) => v.toJson()).toList();

    return data;
  }
}

class Lists extends ListData {
  Lists({
    required List<Weather> weather,
   
  }) : super(weather: weather,);

  factory Lists.fromJson(Map<String, dynamic> json) {
    return Lists(
      weather: (json['list'] as List<dynamic>?)!
            .map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weather'] = weather!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Weather extends WeatherData {
  Weather({
    required int id,
    required String main,
    required String description,
    required String icon,
  }) : super(description: description, id: id, main: main, icon: icon);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}
