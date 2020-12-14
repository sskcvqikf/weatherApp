import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:weatherApp/requests/parseNews.dart';

import 'package:weatherApp/utils/envVars.dart';

import 'package:weatherApp/bloc/newsBloc.dart';

void getLastStateNews() {
  SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
    final _newsBloc = BlocProvider.getBloc<NewsBloc>();
    String stored = myPrefs.getString('news');
    if (stored != null) {
      dynamic decoded = json.decode(stored);
      List<Map<String, String>> appendable = List<Map<String, String>>();
      Map<String, String> tmp = Map<String, String>();
      for (var i in decoded) {
        tmp['author'] = i['author'].toString();
        tmp['title'] = i['title'].toString();
        tmp['img_url'] = 'local';
        tmp['url'] = i['url'].toString();
        tmp['date'] = i['date'].toString();
        appendable.add(Map<String, String>.from(tmp));
      }
      _newsBloc.getNewNews(appendable);
    }
  });
}

void sendCurrentNewsStateBloc() {
  final _newsBloc = BlocProvider.getBloc<NewsBloc>();
  String apiKey = EnvVars.NEWS_API;
  String topic = 'trump';
  String url = 'https://newsapi.org/v2/everything?q=$topic&apiKey=$apiKey';
  http.read(url).then((String raw) {
    var appendable = parseNews(raw);
    _newsBloc.getNewNews(appendable);
    var encoded = json.encode(appendable);
    SharedPreferences.getInstance().then((SharedPreferences myPrefs) {
      myPrefs.setString('news', encoded);
    });
  }).catchError((Object e) {
    getLastStateNews();
  });
}
