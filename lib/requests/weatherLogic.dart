import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:weatherApp/utils/geolocation.dart';
import 'package:weatherApp/utils/envVars.dart';

import 'package:weatherApp/requests/parseWeather.dart';

import 'package:weatherApp/bloc/forecastBloc.dart';
import 'package:weatherApp/bloc/currentWeatherBloc.dart';

void getLastStateForecast() {
  SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
    final _forecastBloc = BlocProvider.getBloc<ForecastBloc>();
    String stored = myPrefs.getString('forecast');
    if (stored != null) {
      dynamic decoded = json.decode(stored);
      List<Map<String, double>> appendable = List<Map<String, double>>();
      Map<String, double> tmp = Map<String, double>();
      for (var i in decoded) {
        tmp['temp'] = double.parse(i['temp'].toString());
        tmp['feels'] = double.parse(i['feels'].toString());
        appendable.add(Map<String, double>.from(tmp));
      }
      _forecastBloc.setNewForecast(appendable);
    }
  });
}

void getLastStateWeather() {
  SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
    final _weatherBloc = BlocProvider.getBloc<CurrentWeatherBloc>();
    String stored = myPrefs.getString('currentWeather');
    if (stored != null) {
      dynamic decoded = json.decode(stored);
      Map<String, String> appendable = Map<String, String>();
      appendable['temp'] = decoded['temp'].toString();
      appendable['feel'] = decoded['feel'].toString();
      appendable['wind_speed'] = decoded['wind_speed'].toString();
      appendable['weather_status'] = decoded['weather_status'].toString();
      appendable['weather_icon'] = decoded['weather_icon'].toString();
      _weatherBloc.setNewCurrentWeather(appendable);
    }
  });
}

void sendCurrentWeatherBlocs() {
  final _currentWeatherBloc = BlocProvider.getBloc<CurrentWeatherBloc>();
  final _forecastBloc = BlocProvider.getBloc<ForecastBloc>();
  getLatLon().then((Position position) {
    double lat = position.latitude.toDouble();
    double lon = position.longitude.toDouble();
    String key = EnvVars.WEATHER_API;
    String url =
        "https://api.openweathermap.org/data/2.5/onecall?lon=$lon&lat=$lat&exclude=daily&appid=$key&units=metric";
    http.read(url).then((String raw) {
      var hourly = getHourlyForecast(raw);
      var current = getCurrentWeather(raw);
      _forecastBloc.setNewForecast(hourly);
      _currentWeatherBloc.setNewCurrentWeather(current);
      var encodedHourly = json.encode(hourly);
      var encodedCurrent = json.encode(current);
      SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
        myPrefs.setString('forecast', encodedHourly);
        myPrefs.setString('currentWeather', encodedCurrent);
      });
    }).catchError((Object e) {
      getLastStateForecast();
      getLastStateWeather();
    });
  });
}
