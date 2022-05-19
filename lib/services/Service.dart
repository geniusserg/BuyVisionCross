import 'dart:convert';
import 'package:http/http.dart' as http;
import '../tokens.dart';

class YandexService {
  static String authUrl = "https://iam.api.cloud.yandex.net/iam/v1/tokens";

  static Future<String?> auth() async {
    String authVar = "{\"yandexPassportOauthToken\" : \"" + authToken + "\"}";
    var response = await http.Client().post(Uri.parse(authUrl),
        headers: {"Content-Type": "application/json"}, body: authVar);
    if (response.statusCode != 200) {
      return null;
    }
    Map<String, dynamic> res = json.decode(response.body);
    if (res.containsKey("code")) {
      return null;
    } else if (res.containsKey("iamToken")) {
      return res['iamToken'];
    }
    return null;
  }

  static Future<String> sendRequest(String reqUrl, String requestJson) async {
    String? token = await auth();
    if (token == null) {
      throw Exception("API Error. Not authenticated in Yandex Cloud");
    }
    var response = await http.Client().post(Uri.parse(reqUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: requestJson,
        encoding: Encoding.getByName("UTF-8"));
    print(utf8.decode(response.bodyBytes));
    return utf8.decode(response.bodyBytes);
  }

  static void execute() {
    // here body
  }
}
