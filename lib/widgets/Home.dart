import 'dart:developer';
import 'dart:io';

import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:buy_vision_crossplatform/widgets/Preview.dart';
import 'package:buy_vision_crossplatform/widgets/TextPage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

import '../models/YandexCloudVisionRequest.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CameraScreen();
                  }));
                },
                child: const Text(str_help_read))),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CameraScreen();
                  }));
                },
                child: const Text(str_help_search))),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TextPage(path: "/storage/emulated/0/DCIM/line-indent.png");
                  }));
                },
                child: const Text("TEST FUNCTIONALITY")))
      ],
    ));
  }
}
