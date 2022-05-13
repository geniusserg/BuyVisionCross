// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';
import 'dart:io';

import 'package:buy_vision_crossplatform/models/YandexCloudRequest.dart';
import 'package:buy_vision_crossplatform/models/YandexCloudVisionRequest.dart';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_downloader/image_downloader.dart';

const imageKazak =
    "https://images.online-otvet.ru/1abc37362c85afc16f3fc863b0f79b08.jpg:thumb";
const imageRus =
    "https://survival-russian.ru/wp-content/uploads/2021/08/2-250x300.jpg";

void main() {
  test("Test recognition service", () async {
    var imagePath = await ImageDownloader.downloadImage(imageKazak);
    print(await RecognitionService.execute(
        request: YandexCloudVisionRequest(path: imagePath ?? "")));
  });

  testWidgets('Test', (WidgetTester tester) async {});
}
