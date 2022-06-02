import 'package:flutter/material.dart';

import '../../resources/strings.dart';
import '../../resources/TextStyles.dart';

Widget loadingWidget() {
  return Center(
      child:
    Semantics(
      label: str_loading_icon,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
      height: 30,
    ),
    CircularProgressIndicator(
      semanticsLabel: "",
    ),
    Container(
      height: 10,
    ),
    Text(
      str_loading,
      style: styleTextRecognized,
    )
  ])));
}

Widget notFound(BuildContext context, String warning) {
  return
    Column(children: [
      Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: Text(warning, style: styleTextRecognized,
            textAlign: TextAlign.center,)
      ),
      Container(height: 20),
      Icon(Icons.search_off_outlined, size: 128, color: Theme
          .of(context)
          .primaryColor,)
    ]);
}