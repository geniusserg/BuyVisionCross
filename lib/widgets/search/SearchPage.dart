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
  late Future<Map<String, String>?> productInfo;
  late Future<List<Map<String, String>>?> searchInfo;

  late String? name;
  late Map<String, String>? productInfoValue;
  late List<Map<String, String>>? searchInfoValue;

  String state = "load";
  String code;

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

  SearchPage({Key? key, required this.code}) : super(key: key){
    nameInfo = BaseSearch.getInfo(code).then((val) {
      name = val;
    });
  }

  @override
  State<SearchPage> createState() => _SearchPageStateFound();

}


class _SearchPageStateFound extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return
          FutureBuilder(
            future: widget.nameInfo,
            builder: (c, snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                if (widget.productInfoValue == null){
                  return Text(str_not_found);
                }
                return Text(widget.name!);
              }
              return widget.loadingWidget();
          });
  }
}


