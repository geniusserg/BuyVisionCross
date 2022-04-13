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
      home: ProductDisplayScreen(
          model: ItemModel(
              headerName: "Сосиски Папа Может вареные ~1 кг",
              largePhoto:
                  "https://sbermarket.ru/spree/products/2223037/preview/15563981.jpg?1624471055")),
    ),
  );
}
