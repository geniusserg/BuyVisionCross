// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:developer';
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
  var gtin = "4607029704351";
  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: FutureBuilder(
            future: GS1Repository.getInfo(gtin),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                log("builder[GS1]: DONE! STATE: " + (snapshot.data as ItemModel?).toString());
                return ProductCard(model: snapshot.data as ItemModel?);
              }
              return Center(child: CircularProgressIndicator());
            })
        )
    );
  }
}
