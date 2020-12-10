import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weatherApp/bloc/cityBloc.dart';
import 'package:weatherApp/bloc/currentWeatherBloc.dart';
import 'package:weatherApp/bloc/forecastBloc.dart';
import 'ui/home/home.dart';
import 'package:flutter/services.dart';

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
