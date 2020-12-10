import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

IconData matchIcon(String icon) {
  switch (icon) {
    case "01n":
      return WeatherIcons.night_clear;
      break;
    case "01d":
      return WeatherIcons.day_sunny;
      break;
    case "02n":
      return WeatherIcons.night_alt_cloudy;
      break;
    case "02d":
      return WeatherIcons.day_cloudy;
      break;
    case "03d":
      return WeatherIcons.cloud;
      break;
    case "03n":
      return WeatherIcons.cloud;
      break;
    case "04d":
      return WeatherIcons.cloudy;
      break;
    case "04n":
      return WeatherIcons.cloudy;
      break;
    case "09d":
      return WeatherIcons.showers;
      break;
    case "09n":
      return WeatherIcons.showers;
      break;
    case "10d":
      return WeatherIcons.day_rain;
      break;
    case "10n":
      return WeatherIcons.night_rain;
      break;
    case "11d":
      return WeatherIcons.day_thunderstorm;
      break;
    case "11n":
      return WeatherIcons.night_thunderstorm;
      break;
    case "13d":
      return WeatherIcons.day_snow;
      break;
    case "13n":
      return WeatherIcons.night_snow;
      break;
    case "50d":
      return WeatherIcons.day_fog;
      break;
    case "50n":
      return WeatherIcons.night_fog;
      break;

    default:
      return WeatherIcons.earthquake;
  }
}
