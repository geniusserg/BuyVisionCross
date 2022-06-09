import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechService {
  String state = "stop";
  FlutterTts? tts;

  void speak(BuildContext context, String? text, String? errText) {
    var talkbackActivated = MediaQuery.of(context).accessibleNavigation;
    if (talkbackActivated) {
      return;
    }
    tts ??= FlutterTts();
    tts!.pauseHandler = () {
      state = "stop";
    };
    tts!.completionHandler = () {
      state = "stop";
    };
    if (state == "stop") {
      tts!.speak(text ?? errText ?? "");
      state = "play";
    } else {
      tts!.stop();
      state = "stop";
    }
  }

  void speakMap(BuildContext context, Map<String, String?>? structure, String? errText) {
    speak(context, getSpeechVersionOfItem(structure), errText);
  }

  void stop() {
    if (tts != null) {
      tts?.stop();
    }
    state = "stop";
  }

  // For widgets with characteristics
  String getSpeechVersionOfItem(Map<String, String?>? currentResult){
    Map<String, String> speechVersion = {};
    if (currentResult == null){
      speechVersion = {"Результат": str_warning_item_not_found};
    }
    if (currentResult!.isEmpty){
      speechVersion = {"Результат": str_warning_item_not_found};
    }
    if (currentResult['shop'] == null){
      if (currentResult['name'] == null){
        speechVersion = {"Результат": str_warning_item_not_found};
      }
      else {
        speechVersion =
        {currentResult['name']!: "", str_add_info_not_found: ""};
      }
    }
    else {
      speechVersion['Информация магазина'] = currentResult['shop']!;
      speechVersion['Название товара'] = currentResult['name']!;
      speechVersion['Цена'] =
      currentResult['price'] == null ? "не найдена" : (currentResult['price']! +
          "RUB"); // tts talks correctly number when RUB in text
      // other parameters
      for (String key in currentResult.keys){
        if (key != "shop" && key != "name" && key != "price" && key != "image"){
          speechVersion[key] = currentResult[key] ?? str_not_found;
        }
      }
    }
    return speechVersion.toString();
  }
}
