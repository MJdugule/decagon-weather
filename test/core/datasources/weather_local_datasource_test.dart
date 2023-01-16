import 'dart:convert';
import 'package:decagon_weather/core/error/exceptions.dart';
import 'package:decagon_weather/core/location/device_location.dart';
import 'package:decagon_weather/features/weather_page/data/datasources/weather_local_datasource.dart';
import 'package:decagon_weather/features/weather_page/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockDeviceLocation extends Mock implements DeviceLocation {}

void main() {
  WeatherLocalDatasourceImpl? dataSource;
  MockSharedPreferences? mockSharedPreferences;
  MockDeviceLocation? mockDeviceLocaton;

  

   setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = WeatherLocalDatasourceImpl(
      sharedPreferences: mockSharedPreferences!,
      deviceLocation: mockDeviceLocaton!,
    );
  });

  group('getLastWeather', () {
    final tWeatherModel =
        WeatherModel.fromJson(json.decode(fixture('weather_cached.json')));

    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences!.getString(""))
            .thenReturn(fixture('weather_cached.json'));
        // act
        final result = await dataSource!.getLastWeather();
        // assert
        verify(mockSharedPreferences!.getString(cachedWeather));
        expect(result, equals(tWeatherModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences!.getString("")).thenReturn(null);
        // act
        final call = dataSource!.getLastWeather();
        // assert
        expect(() => call, throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheWeather', () {
    final weatherModel = WeatherModel(
        weather: [
          Weather(id: 1, main: "main", description: "description", icon: "icon")
        ],
        main: Main(
            temp: 898,
            tempMin: 8989,
            tempMax: 909,
            pressure: 8989,
            humidity: 7676),
        sys: Sys(
            type: 009, id: 88, country: "country", sunrise: 056, sunset: 6767),
        timezone: 456,
        id: 77,
        name: "poo",
        cod: 089);

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource!.cacheWeather(weatherModel);
        // assert
        final expectedJsonString = json.encode(weatherModel.toJson());
        verify(mockSharedPreferences!.setString(
          cachedWeather,
          expectedJsonString,
        ));
      },
    );
  });
}
