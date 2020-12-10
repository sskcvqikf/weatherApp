import 'package:flutter/material.dart';
import 'package:weatherApp/utils/colors.dart';
import 'package:weather_icons/weather_icons.dart';
import '../common/common.dart';
import 'chart.dart';
import 'news.dart';

class CityWeather extends StatelessWidget {
  Widget _buildWeatherIcon() {
    return Icon(WeatherIcons.rain, size: 50, color: SolarizedColorScheme.red);
  }

  Widget _buildCityName() {
    return Container(
        child: ThemedText("LONDON", 35, SolarizedColorScheme.mainBG));
  }

  Widget _buildTemperatureItem(String name, String value) {
    return Container(
      child: Column(
        children: [
          ThemedText(name, 14, SolarizedColorScheme.secondaryBG),
          ThemedText(value, 14, SolarizedColorScheme.secondaryBG),
        ],
      ),
    );
  }

  Widget _buildTemperature() {
    return Container(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
      _buildTemperatureItem("Actual", "15"),
      SizedBox(width: 10),
      _buildTemperatureItem("Feels", "15"),
      SizedBox(width: 10),
      _buildTemperatureItem("Wind Speed", "237ms"),
    ]));
  }

  Widget _buildUpper() {
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
                _buildWeatherIcon(),
                SizedBox(
                  height: 15,
                ),
                _buildCityName(),
                _buildTemperature()
              ]),
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SolarizedColorScheme.mainBG,
      child: Container(
          child: Column(children: [
        _buildUpper(),
        Container(
            decoration: new BoxDecoration(
                color: SolarizedColorScheme.secondaryBG,
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
