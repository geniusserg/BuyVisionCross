import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_core/firebase_core.dart';

final getIt = GetIt.instance;

Future<bool> initFirebase() async {
  try {
    Firebase.initializeApp();
    return true;
  } catch (e) {
    return false;
  }
}
