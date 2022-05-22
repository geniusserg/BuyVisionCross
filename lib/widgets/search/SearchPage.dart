import 'package:buy_vision_crossplatform/repository/BarcodeList.dart';
import 'package:buy_vision_crossplatform/repository/BaseSearch.dart';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/repository/ShopsSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../resources/strings.dart';
import '../../styles/TextStyles.dart';
import 'ProductCard.dart';
import 'ProductHeader.dart';

class SearchPage extends StatefulWidget {
  late Future<String?> nameInfo;
  //late Future<Map<String, String>?> productInfo;
  //late Future<List<Map<String, String>>?> searchInfo;

  String? name;
  Map<String, String>? productInfoValue;
  List<Map<String, String>>? searchInfoValue;

  String state = "load";
  String code;

  SearchPage({Key? key, required this.code}) : super(key: key) {
    nameInfo = BaseSearch.getInfo(code).then((val) {
      name = val;
    });
  }

  @override
  State<SearchPage> createState() => _SearchPageStateFound();
}

class _SearchPageStateFound extends State<SearchPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF94CCF9),
            title: Text(str_search_results, style: styleHeader)),
        body: FutureBuilder(
            future: widget.nameInfo,
            builder: (c, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (widget.name == null) {
                  return Text(str_not_found, style: styleTextRecognized);
                }
                return buildHeader(widget.name!);
              }
              return loadingWidget();
            }));
  }
}
