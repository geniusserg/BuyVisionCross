import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:flutter/material.dart';

class ErrorConnectionPage extends StatelessWidget {
  const ErrorConnectionPage ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(children: const [
        Expanded(child: Icon(Icons.no_cell, color: Colors.black)),
        Text(str_error)
        ]
      )
    );
  }
}