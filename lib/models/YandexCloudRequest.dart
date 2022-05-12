import 'dart:convert';
import 'dart:io';

class YandexCloudRequest {
  String folderId = "";
  Map<String, dynamic> features = {
    "type": "TEXT_DETECTION",
    "text_detection_config": {
      "language_codes": ["*"]
    }
  };
  String? base64;

  YandexCloudRequest({String? file}) {
    if (file != null) {
      setImageFile(File(file));
    }
  }

  Future<void> setImageFile(File? imageFile) async {
    if (imageFile == null) {
      base64 = "";
      return;
    }
    List<int> imageBytes = await imageFile.readAsBytes();
    base64 = base64Encode(imageBytes);
  }

  @override
  String toString() {
    return json.encode({
      "folderId": folderId,
      "analyze_specs": [
        {
          "content": (base64 ?? ""),
          "features": [features]
        }
      ]
    });
  }
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