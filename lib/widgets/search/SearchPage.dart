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
    nameInfo = BaseSearch.getInfo(code).then((value) {
      if (value == null){
        state = "nf";
        searchInfo = Future(() => null);
        name = value;
        return null;
      }
      searchInfo = ShopSearch.getInfo(value).then((v) {
        state = "found";
        searchInfoValue = v;
        return v;
      });
      return value;
    });
  }

  @override
  State<SearchPage> createState(){
    switch (state){
      case "load":
        return _SearchPageLoading();
      case "nf":
        return _NotFoundState();
      case "found":
        return _SearchPageStateFound();
    }
    return _NotFoundState();
  }
}

class _NotFoundState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                alignment: Alignment.center,
                height: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search_off, color: Colors.black, size: 128.0),
                      Text(str_error, style: styleError, textAlign: TextAlign.center)
                    ]))));
  }
}

class _SearchPageStateFound extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Column(
        children:
        [
          ProductHeader(name: widget.name!),
          FutureBuilder(
            future: widget.searchInfo,
            builder: (c, snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                if (widget.productInfoValue == null){
                  return Text(str_not_found);
                }
                return ProductCard(properties: widget.productInfoValue!);
              }
              return widget.loadingWidget();
          })
        ]);
  }
}

class _SearchPageLoading extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.productInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            setState(() {});
          }
          return widget.loadingWidget();
    });
  }
}
