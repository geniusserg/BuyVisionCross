import 'package:buy_vision_crossplatform/models/SearchViewDomain.dart';
import 'package:buy_vision_crossplatform/repository/BarcodeList.dart';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/repository/ShopsSearch.dart';
import 'package:buy_vision_crossplatform/services/SpeechService.dart';
import 'package:buy_vision_crossplatform/widgets/elements/CommonElements.dart';
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
  late SearchViewDomain searchViewDomain;
  late SpeechService speechService;
  int index = 0;

  SearchPage({Key? key, String? code, SearchViewDomain? controller, int? index}) : super(key: key) {
    if (code != null) {
      searchViewDomain = SearchViewDomain(code: code); // just from camera
    }
    else {
      searchViewDomain = controller!; // when it is push from list
      if (index != null) {
        this.index = index;  // page from search list
      }
    }
    speechService = SpeechService();
  }

  @override
  State<SearchPage> createState() => _SearchPageStateFound();
}

class _SearchPageStateFound extends State<SearchPage> {
  void speechButton(BuildContext context) {
    widget.speechService
        .speak(context, widget.searchViewDomain.currentResult.toString(), str_shop_not_found);
  }

  void backButton(BuildContext context) {
    widget.speechService.stop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void moreOptions(BuildContext context) {
    if (widget.searchViewDomain.searchUrls == null) {
      return;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchList(search: widget.searchViewDomain,)));
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
            future: widget.searchViewDomain.getScreenDetailsData(index: widget.index),
            builder: (c, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (widget.searchViewDomain.currentResult!.isEmpty) {
                  return Text(str_not_found, style: styleTextRecognized);
                }
                return ProductCard(properties: widget.searchViewDomain.currentResult!);
              }
              return loadingWidget();
            }),
        bottomNavigationBar: bottomBar(context));
  }
}
