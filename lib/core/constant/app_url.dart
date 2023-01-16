class AppUrl {
  AppUrl._();

  static const String baseUrl = 'https://api.openweathermap.org';
  static const String apiKey = '5130d2ad5e00e01935c7486f7c13a0e5';
  //static const String url =

  static String Function(dynamic lat, dynamic lon) get url =>
      (var lat, var lon) {
        String url;
        url = "/data/2.5/weather?lat=$lat&lon=$lon&exclude=hourly,daily&appid=$apiKey";
           
        return url;
      };
}
