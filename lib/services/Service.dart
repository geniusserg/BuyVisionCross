import 'dart:convert';

import 'package:http/http.dart' as http;

class YandexService {
  static String authUrl = "https://iam.api.cloud.yandex.net/iam/v1/tokens";
  static String authKey = "";
  static String authVar = "{\"yandexPassportOauthToken\" : \"$authKey\"}";

  static Future<String?> auth() async {
    var response = await http.Client().post(Uri.parse(authUrl), body: authVar);
    print(response.statusCode);
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
