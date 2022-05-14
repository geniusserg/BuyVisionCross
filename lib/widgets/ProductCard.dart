import 'package:buy_vision_crossplatform/models/ItemModel.dart';
import 'package:flutter/material.dart';
import '../styles/TextStyles.dart';

class ProductCard extends StatelessWidget {
  final ItemModel model;
 
  const ProductCard({ Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> page = [Text(model.name!), Text(model.gsInfo!.values.join(" "))];
    return Column(children: page);
  }
}
