import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:flutter/cupertino.dart';

class TextPage extends StatelessWidget {
  static String? text;
  TextPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Text(text ?? str_error),
    ));
  }
}
