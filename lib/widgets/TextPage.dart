import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:buy_vision_crossplatform/services/SpeechService.dart';
import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:buy_vision_crossplatform/widgets/Home.dart';
import 'package:buy_vision_crossplatform/widgets/elements/CommonElements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/YandexCloudTranslateRequest.dart';
import '../models/YandexCloudVisionRequest.dart';
import '../services/TranslationService.dart';

class TextPage extends StatefulWidget {
  String path;
  late Future<String?> textActionFuture;
  String action = "recognize";
  String? text;
  late SpeechService speechService;
  TextPage({Key? key, required this.path}) : super(key: key) {
    speechService = SpeechService();
    textActionFuture = YandexRecognitionService.execute(
        request: YandexCloudVisionRequest(path: path));
  }
  @override
  State<StatefulWidget> createState() => TextPageState();
}

class TextPageState extends State<TextPage> {
  void speechButton(BuildContext context) {
    widget.speechService.speak(context, widget.text, str_not_found);
  }

  void backButton(BuildContext context) {
    widget.speechService.stop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void translateButton(BuildContext context) {
    if (widget.text == null) {
      return;
    }
    widget.action = "translate";
    widget.textActionFuture = YandexTranslationService.execute(
        request: YandexCloudTranslateRequest(text: widget.text!));
    setState(() {});
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
            leading: Container(),
            title: Text(str_ocr_header, style: styleHeader)),
        bottomNavigationBar: bottomBar(context),
        body: FutureBuilder(
            future: widget.textActionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (widget.action == "translate") {
                  widget.text = (snapshot.data as String?) ?? widget.text;
                } else {
                  widget.text = (snapshot.data as String?) ?? str_not_found;
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.all(12),
                  child: Text(widget.text!, style: styleTextRecognized),
                );
              }
              return loadingWidget();
            }));
  }
}
