import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:weatherApp/utils/colors.dart';
import 'package:weatherApp/utils/geolocation.dart';
import 'package:weatherApp/utils/matchIcon.dart';

import 'package:weatherApp/requests/weatherLogic.dart';

import 'package:weatherApp/bloc/cityBloc.dart';
import 'package:weatherApp/bloc/currentWeatherBloc.dart';

import 'package:weatherApp/ui/common/common.dart';
import 'package:weatherApp/ui/home/chart.dart';
import 'package:weatherApp/ui/home/news.dart';

class CityWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CityWeatherState();
  }
}

class _CityWeatherState extends State<CityWeather> {
  final _cityBloc = BlocProvider.getBloc<CityBloc>();
  final _currentWeatherBloc = BlocProvider.getBloc<CurrentWeatherBloc>();
  String cityName;
  String currentTemperature;
  String currentFeel;
  String currentWindSpeed;
  String currentWeatherStatus;
  IconData icon = WeatherIcons.earthquake;

  @override
  void dispose() {
    _cityBloc.dispose();
    _currentWeatherBloc.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    getCurrentCity();
    sendCurrentWeatherBlocs();
  }

  Widget _buildWeatherIcon(IconData icon) {
    return Icon(icon, size: 40, color: SolarizedColorScheme.red);
  }

  Widget _buildWeatherState(String state) {
    return Container(
        margin: EdgeInsets.all(10),
        child: ThemedText(state == null ? 'Getting...' : state.toLowerCase(),
            12, SolarizedColorScheme.mainBG));
  }

  Widget _buildCityNameWidget() {
    return StreamBuilder(
        stream: _cityBloc.cityStream,
        builder: (_, AsyncSnapshot<String> snaphot) {
          if (snaphot.hasData) {
            cityName = snaphot.data;
          }
          return Container(
              child: ThemedText(cityName == null ? 'Getting...' : cityName, 20,
                  SolarizedColorScheme.mainBG));
        });
  }

  Widget _buildTemperatureItem(String name, String value, String ed) {
    return Container(
      child: Column(
        children: [
          ThemedText(name, 14, SolarizedColorScheme.secondaryBG),
          ThemedText((value == null ? '-' : value) + ed, 14,
              SolarizedColorScheme.secondaryBG),
        ],
      ),
    );
  }

  Widget _buildTemperature(String temp, String feel, String speed) {
    return Container(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
      _buildTemperatureItem("Temparature", temp, "°C"),
      SizedBox(width: 15),
      _buildTemperatureItem("Feelings", feel, "°C"),
      SizedBox(width: 15),
      _buildTemperatureItem("Wind Speed", speed, "ms"),
    ]));
  }

  Widget _buildUpper() {
    return StreamBuilder(
        stream: _currentWeatherBloc.currentWeatherStream,
        builder: (_, AsyncSnapshot<Map<String, String>> snaphot) {
          if (snaphot.hasData) {
            currentTemperature = snaphot.data['temp'];
            currentFeel = snaphot.data['feel'];
            currentWindSpeed = snaphot.data['wind_speed'];
            currentWeatherStatus = snaphot.data['weather_status'];
            icon = matchIcon(snaphot.data['weather_icon']);
          }
          return Container(
              decoration: new BoxDecoration(
                  color: SolarizedColorScheme.accentFG,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(40, 20, 40, 60),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SolarizedColorScheme.transparent,
                  ),
                  child: Center(
                      child: Container(
                    child: Column(children: [
                      _buildWeatherIcon(icon),
                      SizedBox(
                        height: 25,
                      ),
                      _buildCityNameWidget(),
                      _buildWeatherState(currentWeatherStatus),
                      _buildTemperature(
                          currentTemperature, currentFeel, currentWindSpeed)
                    ]),
                  ))));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SolarizedColorScheme.mainBG,
      child: Container(
          child: Column(children: [
        _buildUpper(),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            )),
            child: Chart()),
        SizedBox(height: 40),
        Container(
            // alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: ThemedText(
              "NEWS:",
              35,
              SolarizedColorScheme.accentFG,
              weight: FontWeight.w400,
            )),
        NewsFeed(),
      ])),
    );
  }
}
