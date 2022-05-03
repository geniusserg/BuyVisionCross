import 'dart:ui';

import 'package:buy_vision_crossplatform/models/ItemModel.dart';
import 'package:flutter/material.dart';

class ProductCardMain extends StatelessWidget {
  final ItemModel? model;
  final TextStyle styleHeader =
      TextStyle(color: Colors.black, fontFamily: "Roboto", fontSize: 28);
  final TextStyle styleManufacturer =
    TextStyle(color: Colors.black, fontFamily: "Roboto", fontSize: 16);
  

  ProductCardMain({required this.model}) {}

  @override
  Widget build(BuildContext context) {
    List<Widget> page = List.empty(growable: true);
    if (model == null) {
      page.add(Text("Not found :("));
    } else {
      page.add(Text(model!.name, style: styleHeader));
      page.add(Text(model!.manufacturer ?? "unknown manufacturer", style: styleManufacturer));
      page.add(Text("Weight: "+(model!.weight ?? "unknown weight") +
          " " +
          (model!.weightType ?? "")));
      if (model!.description != null){
        page.add(Text("Description"));
        page.add(Text(model!.description ?? ""));
      }
    }
    return Scaffold(
        body: SafeArea(child: Column(children: page)));
  }
}
