import 'package:decagon_weather/core/location/device_location.dart' as i6;
import 'package:decagon_weather/features/weather_page/data/datasources/weather_local_datasource.dart'
    as i9;
import 'package:decagon_weather/features/weather_page/data/repositories/weather_repository_impl.dart'
    as i8;
import 'package:decagon_weather/features/weather_page/domain/repostories/weather_repository.dart'
    as i7;
import 'package:decagon_weather/features/weather_page/domain/usecases/request_device_location_usecase.dart'
    as i5;
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_notifier.dart'
    as i4;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart' as i1;

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
  gh.lazySingleton<i4.WeatherNotifier>(() => i4.WeatherNotifier(
        requestDeviceLocationUsecase: get<i5.RequestDeviceLocationUsecase>(),
      ));
  gh.lazySingleton<i5.RequestDeviceLocationUsecase>(() =>
      i5.RequestDeviceLocationUsecase(
          weatherRepository: get<i7.WeatherRepository>()));
  gh.lazySingleton<i6.DeviceLocation>(() => i6.DeviceLocationImpl());
  gh.lazySingleton<i7.WeatherRepository>(() => i8.WeatherRepositoryImpl(
        weatherLocalDatasource: get<i9.WeatherLocalDatasource>(),
      ));
  gh.lazySingleton<i9.WeatherLocalDatasource>(
      () => i9.WeatherLocalDatasourceImpl(deviceLocation: get<i6.DeviceLocation>()));
  return get;
}

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
