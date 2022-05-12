import 'dart:convert';
import 'dart:io';

import 'package:buy_vision_crossplatform/di/dependencies.dart' as di;
import 'package:flutter/services.dart';

class YandexCloudRequest {
  String? folderId = di.folderId;
  String? content;
  Map<String, dynamic>? features;

  YandexCloudRequest() {}

  @override
  String toString() {
    return json.encode({
      "folderId": folderId ?? "",
      "analyze_specs": [
        {
          "content": (content ?? ""),
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