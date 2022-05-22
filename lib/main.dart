import 'dart:async';
import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/ErrorConnection.dart';
import 'package:buy_vision_crossplatform/widgets/TextPage.dart';
import 'package:buy_vision_crossplatform/widgets/search/ProductCard.dart';
import 'package:buy_vision_crossplatform/widgets/search/SearchPage.dart';
import 'package:buy_vision_crossplatform/widgets/search/ShowPhoto.dart';
import 'di/getCamera.dart';
import 'package:buy_vision_crossplatform/widgets/Home.dart';
import 'package:flutter/material.dart';
import '../di/dependencies.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.targetLanguage = "ru";
  di.cameraDescription = await getCamera();
  if (di.cameraDescription == null) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ErrorPage(
            error: str_camera_error,
            icon: Icons.warning)));
    return;
  }


  runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.brown, secondaryHeaderColor: Colors.brown),
      debugShowCheckedModeBanner: false, home: SafeArea(child: ProductCard(properties:
      {
        "name": "Sergey",
        "price": "15,77",
        "image": "https://avatars.mds.yandex.net/i?id=93a172ed3bdbeec6d9b1d7b934c585d3-5590728-images-thumbs&n=13",
        "Описание": "Хороший человек",
        "Срок Хранения": "70 лет"
      }
    ,))));
}
