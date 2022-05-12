import 'dart:convert';
import 'dart:io';

import 'YandexCloudRequest.dart';

class YandexCloudVisionRequest extends YandexCloudRequest{
  Map<String, dynamic>? features = {
    "type": "TEXT_DETECTION",
    "text_detection_config": {
      "language_codes": ["*"]
    }
  };

  String path;

  YandexCloudVisionRequest({required this.path}): super(){
    setImageFile(File(path));
  }


  Future<void> setImageFile(File? imageFile) async {
    if (imageFile == null) {
      content = "";
      return;
    }
    List<int> imageBytes = await imageFile.readAsBytes();
    content = base64Encode(imageBytes);
  }
  
}