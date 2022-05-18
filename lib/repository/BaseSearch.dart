import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';

import 'BarcodeList.dart';

class BaseSearch {
  static Future<String?> getInfo(String gtin) async {
    String? blist = await BarcodeRepository.getInfo(gtin);
    blist ??= (await GS1Repository.getInfo(gtin))?['description'];
    return blist;
  }
}