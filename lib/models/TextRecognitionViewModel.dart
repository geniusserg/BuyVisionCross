import 'package:buy_vision_crossplatform/models/YandexCloudTranslateRequest.dart';
import 'package:buy_vision_crossplatform/models/YandexCloudVisionRequest.dart';
import 'package:buy_vision_crossplatform/services/RecognitionService.dart';
import 'package:camera/camera.dart';

import '../services/TranslationService.dart';

class TextRecognitionViewModel {
  String? text;
  String path;

  TextRecognitionViewModel({required this.path});
  Future<String?> recognizeText() async{
    YandexCloudVisionRequest request = YandexCloudVisionRequest(path: path);
    return YandexRecognitionService.execute(request: request).then((value)
    {
      text = value;
    });
  }

  Future<String?> translateText() async{
    if (text != null) {
      YandexCloudTranslateRequest request = YandexCloudTranslateRequest(text: text!);
      return YandexTranslationService.execute(request: request).then((value) {
        if (value != null){
          text = value;
        }
      });
    }
  }
}