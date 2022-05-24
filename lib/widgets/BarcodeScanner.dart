import 'package:barcode_scan2/gen/protos/protos.pb.dart';
import 'package:buy_vision_crossplatform/widgets/ErrorConnection.dart';
import 'package:buy_vision_crossplatform/widgets/search/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart' as bs2;


import '../resources/strings.dart';
import '../styles/TextStyles.dart';

class BarcodeScanner {
  String? val;

  Future<String?> launchPreviewPage(BuildContext context) async{
    val = (await bs2.BarcodeScanner.scan()).rawContent;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SearchPage(code: val);
    }));
  }

}

