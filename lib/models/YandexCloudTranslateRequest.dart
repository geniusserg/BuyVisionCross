import 'dart:convert';
import "package:buy_vision_crossplatform/tokens.dart";

class YandexCloudTranslateRequest {
  List<String> text;

  YandexCloudTranslateRequest({required this.text});

  Future<String> getJson() async {
    return json.encode(
        {"folderId": folderId, "targetLanguageCode": "ru", "texts": text});
  }
}
