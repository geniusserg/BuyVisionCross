// Yandex Cloud -> Translate -> Text Translation API
// Need OAuth token

import 'package:buy_vision_crossplatform/models/YandexCloudTranslateRequest.dart';
import 'package:buy_vision_crossplatform/services/YandexService.dart';

class YandexTranslationService {
  static String reqUrl =
      "https://translate.api.cloud.yandex.net/translate/v2/translate";

  static Future<String?> execute({required YandexCloudTranslateRequest request}) async {
    var jsn = await request.getJson();
    String result = await YandexService.sendRequest(reqUrl, jsn);
    RegExp exp =  RegExp("\"text\": \".*\"");
    RegExp exp_err =  RegExp("\"message\" : \".*\"");
    Iterable err = exp_err.allMatches(result);
    if (err.isNotEmpty){
      throw Exception("API Error");
    }
    List<String> tmpl = [];
    exp.allMatches(result).forEach((key) => tmpl.add(result.substring(key.start+9, key.end-1)));
    return tmpl.isNotEmpty ? tmpl.join(" ") : null;
  }
}

