import 'package:buy_vision_crossplatform/repository/GoogleSearch.dart';

import 'Auchan.dart';
import 'Lenta.dart';
import 'Shop.dart';
import 'Spar.dart';

class ShopSearch{
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

  static Future<List<Map<String, String?>>?> getInfo(String searchString) async{
    List<String> urls = await GoogleSearch.execute(searchString);
    if (urls.isEmpty){
      return null;
    }
    List<Map<String, String?>> result = [];
    for (String url in urls){
      var t = await ShopSearch.parse(url);
      if (t != null){
        result.add(t);
      }
    }
    return result;
  }
}