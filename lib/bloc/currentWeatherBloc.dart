import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class CurrentWeatherBloc extends BlocBase {
  final _currentWeatherStreamController =
      StreamController<Map<String, String>>();
  Stream<Map<String, String>> get currentWeatherStream =>
      _currentWeatherStreamController.stream;

  @override
  void dispose() {
    _currentWeatherStreamController.close();
    super.dispose();
  }

  void setNewCurrentWeather(Map<String, String> data) {
    _currentWeatherStreamController.add(data);
  }
}
