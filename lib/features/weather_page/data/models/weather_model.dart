import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';

class WeatherModel extends WeatherEntities {
  const WeatherModel({
    required List<Weather> weather,
    required Main main,
    required Sys sys,
    required int timezone,
    required int id,
    required String name,
    required int cod,
  }) : super(
            weather: weather,
            main: main,
            sys: sys,
            timezone: timezone,
            id: id,
            name: name,
            cod: cod);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      weather:   (json['weather'] as List<dynamic>?)!.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      //  {
      //   weather = <Weather>[];
      //   json['weather'].forEach((v) {
      //     weather!.add(Weather.fromJson(v));
      //   });
      // },

      main: Main.fromJson(json['main']),

      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['weather'] = weather.map((v) => v.toJson()).toList();

   
   
      data['main'] = main.toJson();
   

    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
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

class Main extends MainData {
  Main({
    required double temp,
    
    required double tempMin,
    required double tempMax,
    required int pressure,
    required int humidity,
   
    
  }) : super(
           
            temp: temp,
            tempMax: tempMax,
            tempMin: tempMin,
            pressure: pressure,
            humidity: humidity,
            
            );

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temp: json['temp'],
        
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        
       );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
   
    
    return data;
  }
}

class Sys extends SysData {
  Sys(
      {required int type,
      required int id,
      required String country,
      required int sunrise,
      required int sunset})
      : super(
            country: country,
            id: id,
            type: type,
            sunrise: sunrise,
            sunset: sunset);

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
