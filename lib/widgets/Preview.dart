import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class Preview extends StatelessWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 300.0,
      height: 600.0,
      child: QrCamera(
        onError: (context, error) => Text(
          error.toString(),
          style: TextStyle(color: Colors.red),
        ),
        qrCodeCallback: (code) async {
          log("found some");
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                color: Colors.orange, width: 10.0, style: BorderStyle.solid),
          ),
        ),
      ),
    ));
  }
}
