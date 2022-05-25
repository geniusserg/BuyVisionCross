import 'package:buy_vision_crossplatform/widgets/search/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart' as bs2;

class BarcodeScanner {
  String? val;
  Future<String?> launchPreviewPage(BuildContext context) async{
    val = (await bs2.BarcodeScanner.scan()).rawContent;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SearchPage(code: val);
    }));
  }

}

