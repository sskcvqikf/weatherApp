import 'dart:async' show Stream, StreamController;
import 'package:bloc_pattern/bloc_pattern.dart';

class NewsBloc extends BlocBase {
  final _newsStreamController = StreamController<List<Map<String, String>>>();

  Stream<List<Map<String, String>>> get newsStream =>
      _newsStreamController.stream;

  @override
  void dispose() {
    _newsStreamController.close();
    super.dispose();
  }

  void getNewNews(List<Map<String, String>> data) {
    _newsStreamController.add(data);
  }
}
