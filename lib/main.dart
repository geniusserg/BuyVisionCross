import 'dart:async';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/widgets/Home.dart';
import 'package:buy_vision_crossplatform/widgets/ProductCard.dart';
import 'package:flutter/material.dart';
import './di/injection_container.dart' as di;
import 'package:qr_mobile_vision/qr_camera.dart';

bool firebaseInitialized = false;

Future<void> main() async {
  firebaseInitialized = await di.init();
  const String recognizedCode = "4607092074702";
  const String imageUrl = "https://imgproxy.sbermarket.ru/imgproxy/size-1646-1646/aHR0cHM6Ly9z"
                "YmVybWFya2V0LnJ1L3NwcmVlL3Byb2R1Y3RzLzE2MDczMDMvb3JpZ2luYWwvMTk"
                "1OTVfMS5qcGc_MTY0MDAwOTY4Nw.png";

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Center(
        child: Home())
    )
  );

}
