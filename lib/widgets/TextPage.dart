import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/YandexCloudRequest.dart';

class TextPage extends StatelessWidget {
  String path;
  String? text;
  String state = "stop";
  FlutterTts? tts;
  TextPage({Key? key, required this.path}) : super(key: key) {
    tts = FlutterTts();
    if (tts == null) {
      throw Exception("Text to Speech module is not activated");
    }
    tts!.pauseHandler = () {
      state = "stop";
    };
    tts!.completionHandler = () {
      state = "stop";
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: 
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              FloatingActionButton(onPressed: () {
                if (state == "stop") {
                  tts!.speak(text ?? str_loading);
                  state = "play";
                } else {
                  tts!.pause();
                  state = "stop";
                }
              }),
              FloatingActionButton(onPressed: () {
                tts!.stop();
                Navigator.pop(context);
              })
            ]),
            body: FutureBuilder(
                future: RecognitionService.recognizeText(
                    request: YandexCloudRequest()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    text = (snapshot.data as String?);
                    if (text == null) {
                      text = str_not_found;
                    }
                    tts!.speak(text ?? str_error);
                    state = "play";
                    return SingleChildScrollView(
                      child: Text(text!, style: styleTextRecognized),
                    );
                  }
                  return Align(
                      alignment: Alignment(0, 0),
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text(
                          str_loading,
                          style: styleTextRecognized,
                        )
                      ]));
                })));
  }
}
