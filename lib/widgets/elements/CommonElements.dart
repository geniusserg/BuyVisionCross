import 'package:flutter/material.dart';

import '../../resources/strings.dart';
import '../../styles/TextStyles.dart';

Widget loadingWidget() {
  return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(
      height: 30,
    ),
    CircularProgressIndicator(
      semanticsLabel: str_loading_icon,
    ),
    Container(
      height: 10,
    ),
    Text(
      str_loading,
      style: styleTextRecognized,
    )
  ]));
}
