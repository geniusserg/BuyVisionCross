import './OzonParser.dart';
import 'ShopParser.dart';
import 'AuchanParser.dart';
import 'LentaParser.dart';
import 'SparParser.dart';

class ShopSearcher{
  static Map<String, ShopParser> shopParsers = {
    "www.ozon.ru": OzonParser(),
    "spar-online.ru"  : SparParser()
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