
import 'package:buy_vision_crossplatform/models/ItemModel.dart';
import 'package:flutter/material.dart';

class ProductDisplayScreen extends StatelessWidget {
  final ItemModel model;

  const ProductDisplayScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: null,
      body: Column(children: [
        Image.network(model.largePhoto),
        Text(model.headerName, style: const TextStyle(fontSize: 20))
      ])
    );
  }  
}

