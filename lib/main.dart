import 'dart:async';
import 'dart:io';
import 'package:buy_vision_crossplatform/models/SearchPageViewModel.dart';
import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/ErrorConnection.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'di/checkInternetConnection.dart';
import 'di/getCamera.dart';
import 'package:buy_vision_crossplatform/widgets/Home.dart';
import 'package:flutter/material.dart';
import '../di/dependencies.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.cameraDescription = await getCamera();
  if (di.cameraDescription == null) {
    runApp(MaterialApp(
        color: Colors.black54,
        theme: ThemeData(colorScheme: ColorScheme.highContrastLight()),
        debugShowCheckedModeBanner: false,
        home: ErrorPage(
            error: str_camera_error,
            icon: Icons.warning)));
    return;
  }

  if(await hasInternet() == false){
    runApp(MaterialApp(
        color: Colors.black54,
        theme: ThemeData(colorScheme: ColorScheme.highContrastLight()),
        debugShowCheckedModeBanner: false,
        home: ErrorPage(
            error: str_internet_not_found,
            icon: Icons.wifi_off)));
    return;
  }

  runApp(MaterialApp(
    color: Colors.black54,
      theme: ThemeData(colorScheme: ColorScheme.highContrastLight()),
      debugShowCheckedModeBanner: false, home: SafeArea(child: Home())));
  FlutterTts().stop();
}
