import 'dart:async';
import 'package:buy_vision_crossplatform/models/SearchViewDomain.dart';
import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/ErrorConnection.dart';
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

  //SearchViewDomain s = SearchViewDomain(code: "123456789");
  //s.currentResult = {};

  runApp(MaterialApp(
    color: Colors.black54,
      theme: ThemeData(colorScheme: ColorScheme.highContrastLight()),
      debugShowCheckedModeBanner: false, home: SafeArea(child: Home())));



}
