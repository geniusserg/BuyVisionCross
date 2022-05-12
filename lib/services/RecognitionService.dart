// Yandex Cloud -> Vision -> Text Recognition API
// Need OAuth token

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:buy_vision_crossplatform/models/YandexCloudRequest.dart';
import 'package:buy_vision_crossplatform/services/Service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../di/checkInternetConnection.dart';
import 'package:http/http.dart' as http;

class RecognitionService{
  static String reqUrl =
      "https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze";

  static Future<String> execute(
      {required YandexCloudRequest request}) async {
    if (!hasInternet()) {
      throw Exception("No internet connection");
    }

    var result = await YandexService.sendRequest(reqUrl, request.toString());
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
