import 'package:buy_vision_crossplatform/widgets/search/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart' as bs2;

import '../resources/strings.dart';

class BarcodeScanner {
  String? val;
  Future<String?> launchPreviewPage(BuildContext context) async{
    val = (await bs2.BarcodeScanner.scan(options:
      const bs2.ScanOptions(
        autoEnableFlash: true,
        restrictFormat: [bs2.BarcodeFormat.ean13],
        strings: {
          'flash_on': str_help_scan,
          'flash_off': str_help_scan
        }
      )
    )).rawContent;
    if (val != null && val != "") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return SearchPage(code: val);
      }));
    }
  }

}

