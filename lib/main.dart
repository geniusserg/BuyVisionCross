import 'dart:async';

import 'package:buy_vision_crossplatform/widgets/ProductDisplayScreen.dart';
import 'package:flutter/material.dart';
import './widgets/TakePictureScreen.dart';
import './models/ItemModel.dart';
import './widgets/ProductDisplayScreen.dart';
import './widgets/Application.dart';
import './di/injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: "Roboto",
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black54)
        )
      ),
      home: const Application()),
  );
}
