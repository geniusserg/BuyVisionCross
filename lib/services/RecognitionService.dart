// Yandex Cloud -> Vision -> Text Recognition API
// Need OAuth token

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:buy_vision_crossplatform/models/YandexCloudTranslateRequest.dart';
import 'package:buy_vision_crossplatform/services/Service.dart';
import 'package:buy_vision_crossplatform/services/TranslationService.dart';
import '../di/checkInternetConnection.dart';
import 'package:http/http.dart' as http;

import '../models/YandexCloudVisionRequest.dart';

class RecognitionService {
  static String reqUrl =
      "https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze";

  static Future<String?> execute(
      {required YandexCloudVisionRequest request}) async {
    if (await hasInternet() == false) {
      throw Exception("No internet connection");
    }
    var jsn = await request.getJson();
    String result = await YandexService.sendRequest(reqUrl, jsn);
    RegExp exp = RegExp("\"text\": \".*\"");
    RegExp exp_err = RegExp("\"message\" : \".*\"");
    Iterable err = exp_err.allMatches(result);
    if (err.isNotEmpty) {
      throw Exception("API Error");
    }
    List<String> tmpl = [];
    exp.allMatches(result).forEach(
        (key) => tmpl.add(result.substring(key.start + 9, key.end - 1)));
    return tmpl.isNotEmpty ? tmpl.join(" ") : null;
  }
}
