import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:buy_vision_crossplatform/widgets/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/YandexCloudTranslateRequest.dart';
import '../models/YandexCloudVisionRequest.dart';
import '../services/TranslationService.dart';

class TextPage extends StatefulWidget {
  String path;
  late Future<String?> textActionFuture;
  TextPage({Key? key, required this.path}) : super(key: key) {
    textActionFuture = RecognitionService.execute(
        request: YandexCloudVisionRequest(path: path));
  }
  @override
  State<StatefulWidget> createState() => TextPageState();
}

class TextPageState extends State<TextPage> {
  String? text;
  String state = "stop";
  FlutterTts? tts;
  void speechButton(BuildContext context) {
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
      tts!.speak(text ?? str_loading);
      state = "play";
    } else {
      tts!.stop();
      state = "stop";
    }
  }

  void backButton(BuildContext context) {
    if (tts != null) {
      tts!.stop();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void translateButton(BuildContext context) {
    if (text == null) {
      return;
    }
    widget.textActionFuture = TranslationService.execute(
        request: YandexCloudTranslateRequest(text: [text!]));
    setState(() {});
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

  Widget bottomBar(BuildContext context) {
    return BottomAppBar(
        child: Container(
            height: 90,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      //onPressed: () {},
                      onPressed: () {
                        backButton(context);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.navigate_before, size: 40),
                            Text(str_navigate_before, style: styleAppBarText)
                          ]),
                      style: ButtonStyle()),
                  TextButton(
                      //onPressed: () {},
                      onPressed: () {
                        speechButton(context);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.record_voice_over_outlined, size: 50),
                            Text(str_speech_label, style: styleAppBarText)
                          ])),
                  TextButton(
                      //onPressed: () {},
                      onPressed: () {
                        translateButton(context);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.translate, size: 40),
                            Text(str_translate_label, style: styleAppBarText)
                          ])),
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF94CCF9),
            title: Text(str_ocr_header, style: styleHeader)),
        bottomNavigationBar: bottomBar(context),
        body: FutureBuilder(
            future: widget.textActionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                text = (snapshot.data as String?) ?? str_not_found;
                return SingleChildScrollView(
                  child: Text(text!, style: styleTextRecognized),
                );
              }
              return loadingWidget();
            }));
  }
}
