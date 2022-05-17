import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/YandexCloudVisionRequest.dart';

class TextPage extends StatelessWidget {
  String path;
  String? text;
  String state = "stop";
  FlutterTts? tts;
  TextPage({Key? key, required this.path}) : super(key: key) {
  }

  Widget speechButton() {
    return FloatingActionButton(
      child: Icon(Icons.record_voice_over_outlined),
      onPressed: () {
        tts ??= FlutterTts();
        tts!.pauseHandler = () {
          state = "stop";
        };
        tts!.completionHandler = () {
          state = "stop";
        };
        if (state == "stop") {
          tts!.speak(text ?? str_loading);
          state = "play";
        } else {
          tts!.stop();
          state = "stop";
        }
    });
  }

  Widget backButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: "sdf",
      child:Icon(Icons.turn_left),
      onPressed: () {
      tts!.stop();
      Navigator.pop(context);
    });
  }

  Widget loadingWidget() {
    return Center(
        child: Column(children: [
      CircularProgressIndicator(),
      Text(
        str_loading,
        style: styleTextRecognized,
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    var talkbackActivated = MediaQuery.of(context).accessibleNavigation;
    return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(child: backButton(context), label: str_speech),
                  talkbackActivated ? Semantics(): Semantics(child: speechButton(), label: str_back)
                ]),
            body: FutureBuilder(
                future: RecognitionService.execute(
                    request: YandexCloudVisionRequest(path: path)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    text = (snapshot.data as String?) ?? str_not_found;
                    tts!.speak(text!);
                    state = "play";
                    return SingleChildScrollView(
                      child: Text(text!, style: styleTextRecognized),
                    );
                  }
                  return loadingWidget();
                })));
  }
}
