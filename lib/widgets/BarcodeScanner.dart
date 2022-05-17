import 'package:buy_vision_crossplatform/widgets/ProductSearch.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

import '../resources/strings.dart';
import '../styles/TextStyles.dart';

class BarcodeScanner extends StatelessWidget{
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    QrCamera(
        qrCodeCallback: (code) {
          if (code == null){
            throw Exception("Barcode was not found");
          }
          QrMobileVision.stop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductSearchPage(code: code),
            ),
          );
        },
      notStartedBuilder: (context){
        return Center(
            child: Column(children: const [
              CircularProgressIndicator(),
              Text(
                str_loading,
                style: styleTextRecognized,
              )
            ]));
      },
      ),
    );
  }

}