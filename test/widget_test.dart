// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:buy_vision_crossplatform/main.dart';

void main() {
  testWidgets('GS1 RUS API test', (WidgetTester tester) async {
    GS1Repository.getInfo("4607092074702");
  });
}
