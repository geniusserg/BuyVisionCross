import 'dart:async';
import 'dart:convert';
import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:buy_vision_crossplatform/widgets/ErrorConnection.dart';
import 'package:flutter/services.dart';

import 'di/checkInternetConnection.dart';
import 'di/getCamera.dart';
import 'package:buy_vision_crossplatform/widgets/Home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../di/dependencies.dart' as di;
import 'models/YandexCloudVisionRequest.dart';
import 'tokens.dart';

Future<void> main() async {
  /*
  di.cameraDescription = await getCamera();
  if (di.cameraDescription == null) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ErrorPage(
            error: str_camera_error,
            icon: Icon(Icons.camera_alt, color: Colors.black))));
    return;
  }
  */

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: SafeArea(child: Home())));
}
