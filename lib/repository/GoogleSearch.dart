import 'package:buy_vision_crossplatform/tokens.dart';
import 'package:http/http.dart';

class GoogleSearch {
  static String requestUrl =
      "https://customsearch.googleapis.com/customsearch/v1";

  static Future<List<String>> execute(String query) async {
    String token = googleToken;
    var req = requestUrl + "?cx=$googleEng&key=$googleToken&q=query";
    String? result = (await Client().get(Uri.parse(req))).body;
    RegExp exp = RegExp("\"link\": \".*\"");
    RegExp exp_err = RegExp("\"message\" : \".*\"");
    Iterable err = exp_err.allMatches(result);
    if (err.isNotEmpty) {
      throw Exception("API Error");
    }
    List<String> tmpl = [];
    exp.allMatches(result).forEach(
        (key) => tmpl.add(result.substring(key.start + 9, key.end - 1)));
    return tmpl;
  }

}
