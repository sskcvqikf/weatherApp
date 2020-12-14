import 'dart:convert';

List<Map<String, String>> parseNews(String raw) {
  dynamic decoded = json.decode(raw);
  List<Map<String, String>> returnable = List<Map<String, String>>();
  Map<String, String> tmp = Map<String, String>();
  for (var i in decoded['articles']) {
    tmp['author'] = i['author'].toString();
    tmp['title'] = i['title'].toString();
    tmp['img_url'] = i['urlToImage'].toString();
    tmp['url'] = i['url'].toString();
    tmp['date'] = i['publishedAt'].toString();
    returnable.add(Map<String, String>.from(tmp));
  }
  return returnable;
}
