import 'dart:convert';

Map<String, String> getCurrentWeather(String raw) {
  dynamic decoded = json.decode(raw);
  Map<String, String> returnable = Map<String, String>();
  returnable['temp'] = decoded['current']['temp'].toString();
  returnable['feel'] = decoded['current']['feels_like'].toString();
  returnable['wind_speed'] = decoded['current']['wind_speed'].toString();
  returnable['weather_status'] =
      decoded['current']['weather'][0]['description'].toString();
  returnable['weather_icon'] =
      decoded['current']['weather'][0]['icon'].toString();
  return returnable;
}

List<Map<String, double>> getHourlyForecast(String raw) {
  List<Map<String, double>> returnable = List<Map<String, double>>();
  dynamic decoded = json.decode(raw)['hourly'];
  Map<String, double> tmp = Map<String, double>();
  for (var i in decoded.sublist(0, 12)) {
    tmp['temp'] = double.parse(i['temp'].toString());
    tmp['feels'] = double.parse(i['feels_like'].toString());
    returnable.add(Map<String, double>.from(tmp));
  }
  return returnable;
}
