
import "package:http/http.dart" as http;
import 'package:html/parser.dart';

import 'ShopParser.dart';

class OzonParser implements ShopParser {

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
        .getElementsByClassName("uj8 ui-r8")
        .isNotEmpty ? document.getElementsByClassName("uj8 ui-r8")[0]
        .attributes["src"]! : null;

    /* DESCRIPTION */
    String? description = document
        .getElementsByClassName("l1y")
        .isNotEmpty ? document
        .getElementsByClassName("l1y")[0].innerHtml.trim() : null;

    /* PRICE */
    String? price = document
        .getElementsByClassName("wl9 lx")
        .isNotEmpty ? document
        .getElementsByClassName("wl9 lx")[0]
        .getElementsByTagName("span")[0].innerHtml.trim() : null;

    var resultMap = {
      "shop": "Лента",
      "name": description,
      "image": imageUrl,
      "price": price
    };

    /*PROPERTIES*/
    var it = document.getElementsByClassName("s1k");
    it.forEach((prop) {
      String label = prop.getElementsByClassName("k1s")[0].innerHtml.trim();
      if (label == "Артикул") {
        return;
      } // not needed info
      if (label == "ШтрихКод") {
        return;
      } // not needed info
      var valElement = prop.getElementsByClassName("ks1")[0];
      String val = valElement.innerHtml.trim();
      if (valElement
          .getElementsByTagName("a")
          .isNotEmpty) {
        val = valElement.getElementsByTagName("a")[0].innerHtml.trim();
      }
      resultMap[label] = val;
    });

    return resultMap;
  }
}
