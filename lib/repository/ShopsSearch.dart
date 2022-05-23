import 'package:buy_vision_crossplatform/repository/GoogleSearch.dart';

import 'Auchan.dart';
import 'Lenta.dart';
import 'Shop.dart';
import 'Spar.dart';

class ShopParser{
  static Map<String, Shop> shopParsers = {
    "www.auchan.ru": Auchan(),
    "lenta.com" : Lenta(),
    //"spar-online.ru"  : Spar()
  };

  static Future<Map<String, String?>?> parse(String url) async{
    final uri = Uri.parse(url);
    String? shop = uri.host;
    if (shop == null || !shopParsers.containsKey(shop)) {
      return Future(() => null);
    }
    Map<String, String?>? parsedSite;
    try {
      parsedSite = await shopParsers[shop]!.execute(url);
    }
    on Exception{
      return Future(() => null);
    }
    on RangeError{
      return Future(() => null);
    }
    return parsedSite;
  }


}