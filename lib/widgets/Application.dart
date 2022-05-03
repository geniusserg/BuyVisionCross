// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/widgets/ProductCard.dart';
import 'package:flutter/material.dart';
import 'package:buy_vision_crossplatform/models/ItemModel.dart';


class Application extends StatefulWidget {
  Application({Key? key}) : super(key: key);
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final ItemModel? model = null;
  var gtin = "000000000";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ProductCardMain(model: GS1Repository.getInfo("00000000"))
    );
  }



}
