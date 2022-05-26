import 'package:buy_vision_crossplatform/models/SearchPageViewModel.dart';
import 'package:buy_vision_crossplatform/services/SpeechService.dart';
import 'package:buy_vision_crossplatform/widgets/elements/CommonElements.dart';
import 'package:buy_vision_crossplatform/widgets/search/SearchList.dart';
import 'package:flutter/material.dart';
import '../../resources/strings.dart';
import '../../resources/TextStyles.dart';
import '../Home.dart';
import 'ProductCard.dart';

class SearchPage extends StatefulWidget {
  late SearchPageViewModel viewModel;
  late SpeechService speechService;
  int index = 0;

  SearchPage({Key? key, String? code, SearchPageViewModel? controller, int? index}) : super(key: key) {
    if (code != null) {
      viewModel = SearchPageViewModel(code: code); // just from camera
    }
    else {
      viewModel = controller!; // when it is push from list
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
        .speak(context, widget.viewModel.currentResult.toString(), str_shop_not_found);
  }

  void backButton(BuildContext context) {
    widget.speechService.stop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void moreOptions(BuildContext context) {
    if (widget.viewModel.searchUrls == null) {
      return;
    }
    if (widget.viewModel.searchUrls!.isEmpty) {
      return;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchList(search: widget.viewModel,)));
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
            leading: Container(),
            title: Text(str_search_results, style: styleHeader)),
        body: FutureBuilder(
            future: widget.viewModel.getScreenDetailsData(index: widget.index),
            builder: (c, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (widget.viewModel.currentResult!.isEmpty) {
                  return
                    Column(children:[
                    Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topCenter,
                      child: Text(str_warning_item_not_found, style: styleTextRecognized, textAlign: TextAlign.center,)
                    ),
                    Container(height: 20),
                    Icon(Icons.search_off_outlined, size: 128, color: Theme.of(context).primaryColor,)]);
                }
                return ProductCard(properties: widget.viewModel.currentResult!);
              }
              return loadingWidget();
            }),
        bottomNavigationBar: bottomBar(context),
    );
  }
}
