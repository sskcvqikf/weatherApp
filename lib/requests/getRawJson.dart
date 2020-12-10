import 'package:http/http.dart' as http;

Future<String> getRawJson(String url) async {
  var response = await http.read(url);
  return response;
}
