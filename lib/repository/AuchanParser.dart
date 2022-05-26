import "package:http/http.dart" as http;
import 'package:html/parser.dart';

import 'ShopParser.dart';

class AuchanParser implements ShopParser{
  @override
  Future<Map<String, String?>> execute(String url) async {
    var response = await http.Client()
        .get(Uri.parse(url), headers: {
        "Connection": "keep-alive",
        "Cookie":  " qrator_ssid=1653593446.529.pJakbCi9hRbeKz7X-d4kt4fuqu1kmgovmdulls2dea3insuv4; qrator_jsid=1653593444.604.TUexk83WtNxKugtK-9tcbk3f8h57cfbpqnehclc96u1ndn9lg; ",
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36",
        });
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
        .getElementsByClassName("css-m8cbm1").isNotEmpty ? document
        .getElementsByClassName("css-m8cbm1")[0].innerHtml.trim() : null;

    /* PRICE */
    String? price = document.getElementsByClassName("css-1g4pw3f").isNotEmpty ?
      document.getElementsByClassName("css-1g4pw3f")[0].innerHtml.split(" ")[0]
        : null;


    var resultMap = {"shop": "Ашан", "name": description, "image": imageUrl, "price": price};

    /* Large Description */
    String? largeDescription =  document.getElementsByClassName("css-ivaahx").isNotEmpty ?
    document.getElementsByClassName("css-ivaahx")[0].text : null;
    if (largeDescription != null){
      if (largeDescription != ""){
        resultMap["Описание"] = largeDescription;
      }
    }

    /*PROPERTIES*/
    var it = document.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    it.forEach((prop) {
      String label = prop.getElementsByClassName("css-12mfum8")[0].innerHtml.trim();
      String val = prop.getElementsByClassName("css-2619sg")[0].innerHtml.trim();
      resultMap[label] = val;
    });

    return resultMap;
  }
}