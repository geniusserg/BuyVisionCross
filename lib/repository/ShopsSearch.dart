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

  static Future<Map<String, String?>?> parse(String url){
    RegExp searchUrl = RegExp("https://.*/");
    String? shop = searchUrl.firstMatch(url)![0];
    if (shop == null || !shopParsers.containsKey(shop)) {
      return Future(() => null);
    }
    return shopParsers[shop]!.execute(url);
  }

  static Future<List<Map<String, String?>>?> getInfo(String searchString) async{
    List<String> urls = await GoogleSearch.execute(searchString);
    List<Map<String, String?>?> result = [];
    for (String url in urls){
      result.add(await ShopSearch.parse(url));
    }
    result.remove(null);
  }
}