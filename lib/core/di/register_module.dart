import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  http.Client get https => http.Client();
  @preResolve
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();
  Future<SharedPreferences> get sharedPreferences  =>
      SharedPreferences.getInstance();
}
