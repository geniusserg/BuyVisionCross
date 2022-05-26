
import "package:http/http.dart" as http;
import 'package:html/parser.dart';

import 'ShopParser.dart';

class SparParser implements ShopParser {
  @override
  Future<Map<String, String?>> execute(String url) async {
    var response = await http.Client()
        .get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception("Not found");
    }
    var document = parse(response.body);

    /* IMAGE */
    var imageUrl = document
        .getElementsByTagName("img")[0]
        .attributes['src'];
    imageUrl = imageUrl == null ? imageUrl : "https://auchan.com/" + imageUrl;


    /* DESCRIPTION */
    String? description = document
        .getElementsByTagName("h1").isNotEmpty ? document
        .getElementsByTagName("h1")[0].innerHtml.trim() : null;

    /* PRICE */
    String? price = document
        .getElementsByClassName("price_value").isNotEmpty ? document
        .getElementsByClassName("price_value")[0].innerHtml.trim() : null;

    var resultMap = {"shop": "spar-online.com", "image": imageUrl, "description": description, "price": price};

    /*PROPERTIES*/
    var it = document.getElementsByClassName("properties__item");
    it.forEach((prop) {
      String label = prop.getElementsByTagName("div")[0].innerHtml.trim();
      if (label == "Артикул"){return;} // not needed info
      if (label == "ШтрихКод"){return;} // not needed info
      String value = prop.getElementsByTagName("div")[2].innerHtml.trim();
      resultMap[label] = value;
    });

    return resultMap;
  }
}