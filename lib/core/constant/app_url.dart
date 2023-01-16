class AppUrl {
  AppUrl._();

  static const String baseUrl = 'https://api.openweathermap.org';
  static const String apiKey = '024212a03e10882be8403e707a96081a';
  //static const String url =

  static String Function(dynamic lat, dynamic lon) get url =>
      (var lat, var lon) {
        String url;
        url = "/data/2.5/weather?lat=$lat&lon=$lon&exclude=hourly,daily&appid=$apiKey";
           
        return url;
      };
    static String Function(dynamic lat, dynamic lon) get fiveUrl =>
      (var lat, var lon) {
        String url;
        url = "/data/2.5/forecast?lat=$lat&lon=$lon&exclude=hourly,daily&appid=$apiKey";
           
        return url;
      };
}
