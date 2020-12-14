import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:weatherApp/bloc/cityBloc.dart';
import 'package:weatherApp/bloc/currentWeatherBloc.dart';
import 'package:weatherApp/bloc/forecastBloc.dart';
import 'package:weatherApp/bloc/newsBloc.dart';

import 'package:weatherApp/ui/home/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [
          Bloc<CityBloc>((i) => CityBloc()),
          Bloc<CurrentWeatherBloc>((i) => CurrentWeatherBloc()),
          Bloc<ForecastBloc>((i) => ForecastBloc()),
          Bloc<NewsBloc>((i) => NewsBloc()),
        ],
        child: MaterialApp(
          title: 'Weather',
          theme: ThemeData(
            fontFamily: 'SourceCodePro',
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
        ));
  }
}
