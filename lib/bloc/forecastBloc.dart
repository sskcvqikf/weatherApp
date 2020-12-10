import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class ForecastBloc extends BlocBase {
  final _forecastStreamController =
      StreamController<List<Map<String, double>>>();

  Stream<List<Map<String, double>>> get forecastStream =>
      _forecastStreamController.stream;

  @override
  void dispose() {
    _forecastStreamController.close();
    super.dispose();
  }

  void setNewForecast(List<Map<String, double>> data) {
    _forecastStreamController.add(data);
  }
}
