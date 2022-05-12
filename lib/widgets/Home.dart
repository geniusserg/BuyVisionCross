import 'dart:developer';
import 'dart:io';

import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/Preview.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

import '../models/YandexCloudRequest.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> _testFunc() async{
    var req = YandexCloudRequest();
    var imageId = await ImageDownloader.downloadImage(
        "https://sun7-6.userapi.com/s/v1/ig2/9g2Jw0LoYYh13U0X6EvBZ531TghYw7JDHv-XfEXPnX8l9lfzELbto55XJqXKZ_NVRZ7FluHMWWtn_ndtesnOwOIs.jpg?size=1024x649&quality=96&type=album");
    var path = await ImageDownloader.findPath(imageId!);

    req.setImageFile(File(path!));
    log(req.toString());
    return;
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
                },
                child: const Text("TEST FUNCTIONALITY")))
      ],
    ));
  }
}
