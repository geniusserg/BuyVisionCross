
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
        .getElementsByTagName("img")
        .isNotEmpty ? document.getElementsByTagName("img")[4]
        .attributes["src"]! : null;

    /* DESCRIPTION */
    String? description = document
        .getElementsByTagName("h1")
        .isNotEmpty ? document
        .getElementsByTagName("h1")[0].innerHtml.trim() : null;

    /* PRICE */
    String? price = document
        .getElementsByClassName("yl1 y1l")
        .isNotEmpty ? document
        .getElementsByClassName("yl1 y1l")[0]
        .getElementsByTagName("span")[0].innerHtml.trim() : null;

    var resultMap = {
      "shop": "Ашан",
      "name": description,
      "image": imageUrl,
      "price": price
    };

    /*PROPERTIES*/
    var it = document.getElementsByTagName("dl");
    it.forEach((prop) {
      String label = prop.getElementsByTagName("dt")[0].getElementsByTagName("span")[0].innerHtml.trim();
      if (label == "Артикул") {
        return;
      } // not needed info
      if (label == "ШтрихКод") {
        return;
      } // not needed info
      var valElement = prop.getElementsByTagName("dd")[0];
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
