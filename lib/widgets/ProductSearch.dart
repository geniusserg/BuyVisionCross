import 'package:buy_vision_crossplatform/widgets/ProductCard.dart';
import 'package:flutter/material.dart';

import '../models/ItemModel.dart';
import '../resources/strings.dart';
import '../styles/TextStyles.dart';

class ProductSearchPage extends StatefulWidget {
  String code;
  ProductSearchPage({Key? key, required this.code}) : super(key: key);

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  late ItemModel model;
  late String text;

  @override
  void initState(){
    super.initState();
    model = ItemModel(code: widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( body:
    SafeArea(child:
    FutureBuilder(
      future: model.loadInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: ProductCard(model: model),
          );
        }
        else{
          return const CircularProgressIndicator();
        }
      }
    )));
  }
}
