import 'dart:developer';
import 'dart:io';

import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  String path;
  TextPage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future: RecognitionService.recognizeText(imageFile: File(path)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var text = (snapshot.data as String?);
                log("builder[YC OCR]: DONE! STATE: " +
                    (text ?? "Text not found"));
                return SingleChildScrollView(
                  child: Text(text ?? str_not_found),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
