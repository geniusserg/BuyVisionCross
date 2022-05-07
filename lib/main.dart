import 'dart:async';
import 'package:buy_vision_crossplatform/di/checkInternetConnection.dart';
import 'package:buy_vision_crossplatform/services/get_camera.dart';
import 'package:buy_vision_crossplatform/widgets/Home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'di/initFirebase.dart';

bool firebaseInitialized = false;
bool internetConnected = false;
CameraDescription? camera;

Future<void> main() async {
  internetConnected = isAppConnectedToInternet();
  firebaseInitialized = await initFirebase();
  camera = await initCamera();

  const String recognizedCode = "4607092074702";
  const String imageUrl =
      "https://imgproxy.sbermarket.ru/imgproxy/size-1646-1646/aHR0cHM6Ly9z"
      "YmVybWFya2V0LnJ1L3NwcmVlL3Byb2R1Y3RzLzE2MDczMDMvb3JpZ2luYWwvMTk"
      "1OTVfMS5qcGc_MTY0MDAwOTY4Nw.png";
  const String testText =
      "Масло олейна 5 грамм. Срок годности 5 суток. хранить в погребе."
      "Manufactured in Moscow, street proletarskaya. May contain some protein pollutions. Take care for children and dogs.";

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: SafeArea(child: Home())));
}
