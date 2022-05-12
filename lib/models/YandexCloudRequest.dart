import 'dart:convert';
import 'dart:io';

class YandexCloudRequest {
  String folderId = "b1gvmob95yysaplct532";
  Map<String, dynamic> features = {"type": "TEXT_DETECTION", "text_detection_config": {"language_codes": ["*"]}};
  String? base64;

  Future<void> setImageFile(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
  }

  @override
  String toString(){
    return json.encode({"folderId": folderId,
        "analyze_specs": [
          {"content": (base64 ?? ""), "features": [features]}
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