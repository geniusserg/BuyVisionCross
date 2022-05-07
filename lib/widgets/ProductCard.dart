import 'package:buy_vision_crossplatform/models/ItemModel.dart';
import 'package:flutter/material.dart';
import '../styles/TextStyles.dart';

class ProductCard extends StatelessWidget {
  final ItemModel? model;
 
  const ProductCard({ Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> page = List.empty(growable: true);
    if (model == null) {
      page.add(const Text("Not found :("));
    } else {
      page.add(Text(model!.name, style: styleHeader));
      page.add(Text(model!.manufacturer ?? "unknown manufacturer",
          style: styleManufacturer));
      page.add(Text("Weight: " +
          (model!.weight ?? "unknown weight") +
          " " +
          (model!.weightType ?? "")));
      if (model!.description != null) {
        page.add(const Text("Description"));
        page.add(Text(model!.description ?? ""));
      }
    }
    return Scaffold(body: Column(children: page));
  }
}
