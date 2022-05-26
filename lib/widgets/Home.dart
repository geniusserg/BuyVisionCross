import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:buy_vision_crossplatform/widgets/BarcodeScanner.dart';
import 'package:buy_vision_crossplatform/widgets/Preview.dart';
import 'package:buy_vision_crossplatform/widgets/search/SearchPage.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(12),
        
          child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CameraScreen();
                }));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Icon(Icons.zoom_in, size: 200, semanticLabel: "look up"),
                const Text(str_help_read, style: styleMenu)
              ])),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(12),
          child: OutlinedButton(
            onPressed: () {
              BarcodeScanner().launchPreviewPage(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Icon(Icons.qr_code_scanner,
                  size: 200, semanticLabel: "look up"),
              const Text(str_help_search, style: styleMenu)
            ])))),
      ],
    ));
  }
}
