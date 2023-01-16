import 'dart:convert';

import 'package:decagon_weather/core/constant/app_url.dart';
import 'package:decagon_weather/core/error/exceptions.dart';
import 'package:decagon_weather/features/weather_page/data/models/weather_model.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather({required String lat, required String lon});
}

@LazySingleton(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<WeatherModel> getCurrentWeather({required String lat, required String lon}) =>
      _getWeatherFromUrl(AppUrl.baseUrl + AppUrl.url(lat, lon));

  Future<WeatherModel> _getWeatherFromUrl(String url) async {
    //print(url);
    final response = await client.get(
      Uri.parse(url),
      
    );

    if (response.statusCode == 200) {
     //print(response.body);
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      
      throw ServerException();
    }
  }
}
