import 'dart:convert';
import 'dart:io';

import 'YandexCloudRequest.dart';

class YandexCloudVisionRequest implements YandexCloudRequest {
  @override
  Map<String, dynamic>? getFeatures() {
    return {
      "type": "TEXT_DETECTION",
      "text_detection_config": {
        "language_codes": ["*"]
      }
    };
  }

  @override
  String? getContent() {
    return content;
  }

  String path;
  String? content;

  YandexCloudVisionRequest({required this.path}) {
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
