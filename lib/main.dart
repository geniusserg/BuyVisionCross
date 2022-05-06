import 'dart:async';
import 'dart:io';

import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/widgets/ProductCard.dart';
import 'package:flutter/material.dart';
import './models/ItemModel.dart';
import './widgets/Application.dart';
import './di/injection_container.dart' as di;
import 'package:qr_mobile_vision/qr_camera.dart';

Future<void> main() async {
  await di.init();
  String recognizedCodeApple = "4607092074702";

  // DEBUG!
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue,
          fontFamily: "Roboto",
          scaffoldBackgroundColor: Colors.white,
          textTheme:
          const TextTheme(bodyText2: TextStyle(color: Colors.black54))),
      home: Center(
          child: Application(
          ))));
  /*
  runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blue,
            fontFamily: "Roboto",
            scaffoldBackgroundColor: Colors.white,
            textTheme:
            const TextTheme(bodyText2: TextStyle(color: Colors.black54))),
        home: Center(
          child: SizedBox(
            width: 300.0,
            height: 600.0,
            child: QrCamera(
              onError: (context, error) =>
                  Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
              qrCodeCallback: (code) async {
                print(await GS1Repository.getInfo(code));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.orange,
                      width: 10.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
          ),
        )));

   */
}
