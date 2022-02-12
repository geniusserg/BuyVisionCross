import 'dart:async';

import 'package:flutter/material.dart';
import './widgets/TakePictureScreen.dart';
import './di/injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(),
    ),
  );
}

