// Yandex Cloud -> Vision -> Text Recognition API
// Need OAuth token

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:buy_vision_crossplatform/models/YandexCloudRequest.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../di/checkInternetConnection.dart';
import 'package:http/http.dart' as http;

class RecognitionService {
  static String authUrl = "https://iam.api.cloud.yandex.net/iam/v1/tokens";
  static String authKey = "ENTER KEY";
  static String authVar = "{\"yandexPassportOauthToken\" : \"$authKey\"}";
  static String reqUrl  = "https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze";

  static Future<String?> _auth() async {
    var response = await http.Client().get(Uri.parse(authUrl));
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

  static Future<String> _sendRequest(String token, String requestJson) async{
    var response = await http.Client().post(
      Uri.parse(reqUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: requestJson
    );
    return response.body;
  }

  static Future<String> recognizeText({required File imageFile}) async {
    if (imageFile == null || !(await imageFile.exists())) {
      throw Exception("No image file was found");
    }

    if (!hasInternet()) {
      throw Exception("No internet connection");
    }

    var iamCode = await _auth();
    if (iamCode == null) {
      throw Exception("Can not authorize in yandex cloud service");
    }

    var req = YandexCloudRequest();
    req.setImageFile(imageFile);

    log(await _sendRequest(iamCode, req.toString()));

    // change on real when cloud is running
    return Future.delayed(Duration(milliseconds: 3000), () {
      return "Масло олейна 5 грамм. Срок годности 5 суток. хранить в погребе."
          "Manufactured in Moscow, street proletarskaya. May contain some protein pollutions. Take care for children and dogs.";
    });
  }
}
