import 'dart:io';

import 'package:buy_vision_crossplatform/di/checkInternetConnection.dart';
import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/resources/TextStyles.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class ErrorPage extends StatelessWidget {
  IconData? icon;
  String error;
  ErrorPage({Key? key, required this.error, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                Icon(icon ?? Icons.error_outline, size: 128.0),
                Text(error, style: styleError, textAlign: TextAlign.center),
                Container(height: 28,),
                TextButton(onPressed: () async {
                  if (this.icon == Icons.wifi_off) {
                    if(await hasInternet() == true){
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home()));
                    }
                  }
                 }, child: Text(str_retry, style: styleMenu))
        ]))));
  }
}
