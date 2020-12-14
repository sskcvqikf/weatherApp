import 'dart:convert';
import 'dart:async' show Stream, StreamController;
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

void getLastStateForecast() {
  SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
    final _forecastBloc = BlocProvider.getBloc<ForecastBloc>();
    String stored = myPrefs.getString('forecast');
    if (stored != null) {
      dynamic decoded = json.decode(stored);
      List<Map<String, double>> appendable = List<Map<String, double>>();
      Map<String, double> tmp = Map<String, double>();
      for (var i in decoded) {
        tmp['temp'] = double.parse(i['temp'].toString());
        tmp['feels'] = double.parse(i['feels'].toString());
        appendable.add(Map<String, double>.from(tmp));
      }
      _forecastBloc.setNewForecast(appendable);
    }
  });
}

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
