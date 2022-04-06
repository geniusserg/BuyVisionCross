import 'dart:async';

import 'package:buy_vision_crossplatform/widgets/ProductDisplayScreen.dart';
import 'package:flutter/material.dart';
import './widgets/TakePictureScreen.dart';
import './models/ItemModel.dart';
import './widgets/ProductDisplayScreen.dart';
import './di/injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: ProductDisplayScreen(model: ItemModel(id: 0, text:"hello", date:"2 march", photo:null)),
    ),
  );
}
