import 'dart:developer';
import 'dart:io';

import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:buy_vision_crossplatform/widgets/Preview.dart';
import 'package:buy_vision_crossplatform/widgets/TextPage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

import '../models/YandexCloudRequest.dart';
import '../models/YandexCloudVisionRequest.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> _testFunc() async {
    const barcodeImg =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7q3L9clDMEXGs2ndmxJmsTpySB5NL_uksyA&usqp=CAU";
    const imageKazak =
        "https://images.online-otvet.ru/1abc37362c85afc16f3fc863b0f79b08.jpg:thumb";
    const imageRus =
        "https://survival-russian.ru/wp-content/uploads/2021/08/2-250x300.jpg";

    var imagePath = await ImageDownloader.downloadImage(imageKazak);
    print(imagePath);
    print("l   " +
        await RecognitionService.execute(
            request: YandexCloudVisionRequest(path: imagePath!)));
  }

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
                  _testFunc();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //  return TextPage(path: "");
                  //}));
                },
                child: const Text("TEST FUNCTIONALITY")))
      ],
    ));
  }
}
