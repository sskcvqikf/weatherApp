import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherApp/requests/getRawJson.dart';
import 'package:weatherApp/requests/parseWeather.dart';
import 'package:weatherApp/utils/envVars.dart';
import 'package:weatherApp/utils/geolocation.dart';
import 'package:weatherApp/bloc/forecastBloc.dart';
import 'package:weatherApp/bloc/currentWeatherBloc.dart';

// Example of request
//

void sendCurrentWeatherBlocs() {
  final _currentWeatherBloc = BlocProvider.getBloc<CurrentWeatherBloc>();
  final _forecastBloc = BlocProvider.getBloc<ForecastBloc>();
  getLatLon().then((Position position) {
    double lat = position.latitude.toDouble();
    double lon = position.longitude.toDouble();
    String key = EnvVars.WEATHER_API;
    String url =
        "https://api.openweathermap.org/data/2.5/onecall?lon=$lon&lat=$lat&exclude=daily&appid=$key&units=metric";
    print(url);
    getRawJson(url).then((String raw) {
      _forecastBloc.setNewForecast(getHourlyForecast(raw));
      _currentWeatherBloc.setNewCurrentWeather(getCurrentWeather(raw));
    });
  });
}
