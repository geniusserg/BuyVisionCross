// Yandex Cloud -> Language -> Translation API
// Need OAuth token

import 'dart:convert';
import 'package:buy_vision_crossplatform/models/YandexCloudRequest.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../di/checkInternetConnection.dart';
import 'package:http/http.dart' as http;

class TranslationService {
  static String authUrl = "https://iam.api.cloud.yandex.net/iam/v1/tokens";
  static String authKey = "";
  static String authVar = "{\"yandexPassportOauthToken\" : \"$authKey\"}";
  static String reqUrl =
      "https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze";

  static Future<String?> _auth() async {
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

  static Future<String> _sendRequest(String token, String requestJson) async {
    var response = await http.Client().post(Uri.parse(reqUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: requestJson);
    return response.body;
  }

  static Future<String> recognizeText(
      {required YandexCloudRequest request}) async {
    if (!hasInternet()) {
      throw Exception("No internet connection");
    }

    var iamCode = await _auth();
    if (iamCode == null) {
      throw Exception("No access to API");
    }

    var result = await _sendRequest(iamCode, request.toString());
    Map<String, dynamic> dictResult = json.decode(result);
    if (dictResult.containsKey("code")) {
      Exception("No access to API");
    }

    // change on real when cloud is running
    return Future.delayed(Duration(milliseconds: 3000), () {
      return "Масло олейна 5 грамм. Срок годности 5 суток. хранить в погребе.";
    });
  }
}
