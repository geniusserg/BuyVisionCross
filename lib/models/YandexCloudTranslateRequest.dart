import 'dart:convert';
import 'dart:io';
import "package:buy_vision_crossplatform/tokens.dart";

import '../di/dependencies.dart';


class YandexCloudTranslateRequest {
  List<String> text;

  YandexCloudTranslateRequest({required this.text});

  Future<String> getJson() async{
    return json.encode({
      "folderId": folderId,
      "targetLanguageCode": targetLanguage ?? "ru",
      "texts": text
    });
  }

}
