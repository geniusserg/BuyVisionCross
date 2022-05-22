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

  void stop() {
    if (tts != null) {
      tts?.stop();
    }
    state = "stop";
  }

  String? mapToString(Map<String, String> map) {}
}
