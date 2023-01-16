import 'package:decagon_weather/core/di/register_module.dart' as i14;
import 'package:decagon_weather/core/location/device_location.dart' as i6;
import 'package:decagon_weather/core/network/network_info.dart' as i10;
import 'package:decagon_weather/features/weather_page/data/datasources/weather_local_datasource.dart'
    as i9;
import 'package:decagon_weather/features/weather_page/data/datasources/weather_remote_datasource.dart'
    as i11;
import 'package:decagon_weather/features/weather_page/data/repositories/weather_repository_impl.dart'
    as i8;
import 'package:decagon_weather/features/weather_page/domain/repostories/weather_repository.dart'
    as i7;
import 'package:decagon_weather/features/weather_page/domain/usecases/get_current_weather.dart' as i16;
import 'package:decagon_weather/features/weather_page/domain/usecases/request_device_location_usecase.dart'
    as i5;
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_notifier.dart'
    as i4;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart' as i1;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as i12;
import 'package:shared_preferences/shared_preferences.dart' as i13;
import 'package:http/http.dart' as i15;

GetIt di = GetIt.instance;
@injectableInit
Future<void> configureDependencies() => $initGetIt(di);

Future<i1.GetIt> $initGetIt(
  i1.GetIt get, {
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  final gh = GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  // final registerModule = _$RegisterModule();
  // gh.lazySingleton<_i2.HomeRepository>(() => _i28.HomeRepositoryImpl(
  //       remoteDatasource: get<_i26.HomeRemoteDatasource>(),
  //       homeLocalDatasource: get<_i11.HomeLocalDatasource>(),
  //     ));

  final registerModule = _$RegisterModule();
  gh.lazySingleton<i4.WeatherNotifier>(() => i4.WeatherNotifier(
    currentWeather: get<i16.CurrentWeatherUsecase>(),
        requestDeviceLocationUsecase: get<i5.RequestDeviceLocationUsecase>(),
        
      ));

  gh.lazySingleton<i16.CurrentWeatherUsecase>(() => i16.CurrentWeatherUsecase(weatherRepository: get<i7.WeatherRepository>()));
  gh.lazySingleton<i5.RequestDeviceLocationUsecase>(() =>
      i5.RequestDeviceLocationUsecase(
          weatherRepository: get<i7.WeatherRepository>()));
  gh.lazySingleton<i6.DeviceLocation>(() => i6.DeviceLocationImpl());
  await gh.factoryAsync<i13.SharedPreferences>(() => registerModule.sharedPreferences, preResolve: true);
  gh.factory<i15.Client>(() => registerModule.https);
  gh.lazySingleton<i12.InternetConnectionChecker>(() => registerModule.internetConnectionChecker);
  gh.lazySingleton<i10.NetworkInfo>(() => i10.NetworkInfoImpl(
      connectionChecker: get<i12.InternetConnectionChecker>()));
  gh.lazySingleton<i7.WeatherRepository>(() => i8.WeatherRepositoryImpl(
        weatherLocalDatasource: get<i9.WeatherLocalDatasource>(),
        networkInfo: get<i10.NetworkInfo>(),
        weatherRemoteDatasource: get<i11.WeatherRemoteDataSource>(),
      ));

  gh.lazySingleton<i9.WeatherLocalDatasource>(() =>
      i9.WeatherLocalDatasourceImpl(
          deviceLocation: get<i6.DeviceLocation>(),
          sharedPreferences: get<i13.SharedPreferences>()));
    gh.lazySingleton<i11.WeatherRemoteDataSource>(() =>
      i11.WeatherRemoteDataSourceImpl(
        client: get<i15.Client>()
          ));
          
  return get;
}

class _$RegisterModule extends i14.RegisterModule {}

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  // di.registerFactory(
  //   () => Provider(
  //     create: (_) => di<WeatherNotifier>(),
  //   ),
  // );

  // Use cases
  // sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  // sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // // Repository
  // sl.registerLazySingleton<NumberTriviaRepository>(
  //   () => NumberTriviaRepositoryImpl(
  //     localDataSource: sl(),
  //     networkInfo: sl(),
  //     remoteDataSource: sl(),
  //   ),
  // );

  // // Data sources
  // sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
  //   () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  // );

  // sl.registerLazySingleton<NumberTriviaLocalDataSource>(
  //   () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  // );

  // //! Core
  // sl.registerLazySingleton(() => InputConverter());
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}
