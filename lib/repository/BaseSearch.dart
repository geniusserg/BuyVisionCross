import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/repository/Shop.dart';

import 'BarcodeList.dart';
import 'ShopsSearch.dart';

class BaseSearch {
  static Future<Map<String, String?>> getInfo(String gtin) async {
    String? blist = await BarcodeRepository.getInfo(gtin);
    if (blist == null){
      return {};
    }

    List<Map<String, String?>>? parsed = await ShopSearch.getInfo(blist);
    if (parsed == null || parsed.isEmpty){
      return {"shop": "gs1.ru", "name": blist, "image": null, "price": null};
    }

    return parsed[0];
  }
}