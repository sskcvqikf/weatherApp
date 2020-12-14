import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weatherApp/bloc/cityBloc.dart';

Future<Position> getLatLon() async {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position position = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  return position;
}

void getCurrentCity() {
  final _cityBloc = BlocProvider.getBloc<CityBloc>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  getLatLon().then((Position position) {
    geolocator
        .placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> p) {
      Placemark place = p[0];
      _cityBloc.setNewCity("${place.locality}");
    });
  });
}
