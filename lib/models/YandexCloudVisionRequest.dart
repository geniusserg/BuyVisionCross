import 'dart:convert';
import 'dart:io';
import "package:buy_vision_crossplatform/tokens.dart";


class YandexCloudVisionRequest {

  Map<String, dynamic>? getFeatures() {
    return {
      "type": "TEXT_DETECTION",
      "text_detection_config": {
        "language_codes": ["*"]
      }
    };
  }

  Future<String?> getContent() async {
    if (content == null) {
      List<int> imageBytes = await File(path).readAsBytes();
      content = base64Encode(imageBytes);
    }
    return content;
  }

  String path;
  String? content;

  YandexCloudVisionRequest({required this.path});


  Future<String> getJson() async{
    return json.encode({
      "folderId": folderId,
      "analyze_specs": [
        {
          "content": (await getContent() ?? ""),
          "features": [getFeatures()]
        }
      ]
    });
  }

}
