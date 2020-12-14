import 'dart:async' show Stream, StreamController;
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

void getLastStateCity() {
  SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
    final _cityBloc = BlocProvider.getBloc<CityBloc>();
    String city = myPrefs.getString('city');
    if (city != null) {
      _cityBloc.setNewCity(city);
    }
  });
}

class CityBloc extends BlocBase {
  final _cityStreamController = StreamController<String>();
  Stream<String> get cityStream => _cityStreamController.stream;

  @override
  void dispose() {
    cityStream.last.then((String city) {
      print(city);
      SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
        myPrefs.setString('city', city);
        _cityStreamController.close();
        super.dispose();
      });
    });
  }

  void setNewCity(String city) {
    _cityStreamController.add(city);
  }
}
