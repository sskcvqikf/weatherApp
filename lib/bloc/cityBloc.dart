import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:weatherApp/utils/geolocation.dart';

class CityBloc extends BlocBase {
  final _cityStreamController = StreamController<String>();
  Stream<String> get cityStream => _cityStreamController.stream;

  @override
  void dispose() {
    _cityStreamController.close();
    super.dispose();
  }

  void setNewCity(String city) {
    _cityStreamController.add(city);
  }
}
