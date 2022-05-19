import 'package:flutter/material.dart';

import '../../resources/strings.dart';
import '../../styles/TextStyles.dart';

class TextPageAppBar extends StatelessWidget {
  const TextPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  //onPressed: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.navigate_before, size: 40),
                    Text(str_navigate_before, style: styleAppBarText)
                  ])),
              Container(

                  //onPressed: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.record_voice_over_outlined, size: 60),
                    Text(str_speech_label, style: styleAppBarText)
                  ])),
              Container(
                  //onPressed: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.translate, size: 40),
                    Text(str_translate_label, style: styleAppBarText)
                  ])),
            ]));
  }
}
