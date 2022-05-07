import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  Icon? icon;
  String error;
  ErrorPage({Key? key, required this.error, this.icon}) : super(key: key);

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
          Icon(Icons.no_cell, color: Colors.black, size: 128.0),
          Text(error, style: styleError, textAlign: TextAlign.center)
        ]))));
  }
}
