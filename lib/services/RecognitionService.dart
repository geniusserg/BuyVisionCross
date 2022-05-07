import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecognitionService {
  static String authKey = "ENTER KEY";

  static Future<String> recognizeText({required File imageFile}) async {
    if (imageFile == null) {
      throw Exception("No imageFile found");
    } 
    return 
      "Масло олейна 5 грамм. Срок годности 5 суток. хранить в погребе."
      "Manufactured in Moscow, street proletarskaya. May contain some protein pollutions. Take care for children and dogs.";
  }

}
