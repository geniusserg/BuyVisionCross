import 'package:buy_vision_crossplatform/repository/BarcodeList.dart';
import 'package:buy_vision_crossplatform/repository/BaseSearch.dart';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/repository/ShopsSearch.dart';
import 'package:buy_vision_crossplatform/widgets/search/SearchList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import '../../resources/strings.dart';
import '../../styles/TextStyles.dart';
import '../Home.dart';
import 'ProductCard.dart';

class SearchPage extends StatefulWidget {
  late Future<Map<String, String?>?> productInfo;

  Map<String, String>? productInfoValue;
  String code = "";

  SearchPage({Key? key, required this.code}) : super(key: key) {
    productInfo = BaseSearch.getInfo(code).then((val) {
      productInfoValue = {};
      val.forEach((key, value) {
        value ??= str_not_found;
        productInfoValue?.addEntries([MapEntry(key, value)]);
      });
    });
  }

  SearchPage.fromUrl({Key? key, String? url}) : super(key: key) {
    productInfo = ShopSearch.parse(url!).then((val) {
      productInfoValue = {};
      val?.forEach((key, value) {
        value ??= str_not_found;
        productInfoValue?.addEntries([MapEntry(key, value)]);
      });
    });
  }

  SearchPage.fromMap({Key? key, required Map<String, String> map})
      : super(key: key) {
    productInfo = Future(() => map).then((val) {
      productInfoValue = map;
    });
  }

  @override
  State<SearchPage> createState() => _SearchPageStateFound();
}

class _SearchPageStateFound extends State<SearchPage> {
  FlutterTts? tts;
  String state = "stop";

  Widget loadingWidget() {
    return SizedBox.expand(
        child: Container(
            alignment: Alignment.center,
            child: Column(children: [
              CircularProgressIndicator(),
              Text(
                str_loading,
                style: styleTextRecognized,
              )
            ])));
  }

  void speechButton(BuildContext context) {
    var talkbackActivated = MediaQuery.of(context).accessibleNavigation;
    if (talkbackActivated) {
      return;
    }
    if (widget.productInfoValue == null) {
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
      tts!.speak(widget.productInfoValue != null
          ? widget.productInfoValue.toString()
          : str_loading);
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

  void moreOptions(BuildContext context) {
    if (widget.productInfoValue == null) {
      return;
    }
    if (widget.productInfoValue!['shop'] == "gs1.ru") {
      return;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchList()));
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
                            Icon(Icons.record_voice_over_outlined, size: 40),
                            Text(str_speech_label, style: styleAppBarText)
                          ])),
                  TextButton(
                      onPressed: () {
                        moreOptions(context);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_outlined, size: 40),
                            Text(str_more_button, style: styleAppBarText)
                          ])),
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF94CCF9),
            title: Text(str_search_results, style: styleHeader)),
        body: FutureBuilder(
            future: widget.productInfo,
            builder: (c, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (widget.productInfoValue == null ||
                    widget.productInfoValue!.isEmpty) {
                  return Text(str_not_found, style: styleTextRecognized);
                }
                return ProductCard(properties: widget.productInfoValue);
              }
              return loadingWidget();
            }),
        bottomNavigationBar: bottomBar(context));
  }
}
