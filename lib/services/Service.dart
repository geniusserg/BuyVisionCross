import 'dart:convert';

import 'package:buy_vision_crossplatform/di/dependencies.dart' as di;
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
        body: requestJson);
    return response.body;
  }

  static void execute() {
    // here body
  }
}
