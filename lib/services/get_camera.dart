import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<CameraDescription> initCamera() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  return firstCamera;
}