import 'dart:convert';
import 'dart:io';

class YandexCloudRequest {
  String folderId = "b1gvmob95yysaplct532";
  Map<String, dynamic> features = {"type": "TEXT_DETECTION", "text_detection_config": {"language_codes": ["*"]}};
  List<Map<String, dynamic>> analyze_spec = [{"content": base64, }]
  String? base64;
  Future<void> setImageFile(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
  }
  Future<void> getJson
}

/*
{
    "folderId": "b1gvmob95yysaplct532",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        "features": [{
            "type": "TEXT_DETECTION",
            "text_detection_config": {
                "language_codes": ["*"]
            }
        }]
    }]
}

*/