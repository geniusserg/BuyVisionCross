import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../di/injection_container.dart';

class FirebaseRecognitionService {
  final CameraDescription camera = getIt(); // your camera instance

  Future<String> recognizeText({required File image}) async {
    final firebaseVision = GoogleMlKit.vision.textDetector();
    final inputImage = InputImage.fromFile(image);
    var resultText = firebaseVision.processImage(inputImage).then((recognisedText) {
      return recognisedText.text;
    });
    return resultText;
  }

  Future<String> recognizeBarcodes({required File image}) async {
    final firebaseVision = GoogleMlKit.vision.barcodeScanner([BarcodeFormat.ean13]);
    final inputImage = InputImage.fromFile(image);
    var resultBarcode = firebaseVision.processImage(inputImage)
        .then((recognisedBarcodes) {return recognisedBarcodes[0].value.displayValue ?? "No barcode";});
    return resultBarcode;
  }
}
