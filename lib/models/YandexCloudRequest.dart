import 'dart:convert';
import 'dart:io';

import 'package:buy_vision_crossplatform/di/dependencies.dart' as di;
import 'package:flutter/services.dart';
import '../tokens.dart';

abstract class YandexCloudRequest {
  String? getContent();

  Map<String, dynamic>? getFeatures();

  YandexCloudRequest();

  @override
  String toString() {
    return json.encode({
      "folderId": folderId,
      "analyze_specs": [
        {
          "content": (getContent() ?? ""),
          "features": [getFeatures()]
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