import "package:http/http.dart" as http;
import 'package:html/parser.dart';

import 'Shop.dart';

class Auchan implements Shop{
  @override
  Future<Map<String, String?>> execute(String url) async {
    var response = await http.Client()
        .get(Uri.parse(url), headers: {
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36 Edg/101.0.1210.39",
          "Cookie": "mindboxDeviceUUID=0; directCrm-session=0; isAddressPopupShown_=true; region_id=1; merchant_ID_=1; methodDelivery_=1; _GASHOP=001_Mitishchi; _ym_uid=1; _ym_d=1652876866; tmr_lvid=8; tmr_lvidTS=1; rrpvid=1; _ym_isad=2; rcuid=8; rrviewed=830811; qrator_jsid=1652881922.335.kJJKO0oxU0nVRaSd-5l7ubprpgu3dbjhqqmu8rm1hj8qao8kt; rr-viewItemId=830811; rrlevt=10; tmr_detect=06; tmr_reqNum=31"
        });
    if (response.statusCode != 200) {
      throw Exception("Not found");
    }
    var document = parse(response.body);

    /* IMAGE */
    var imageUrl = document
        .getElementsByTagName("img")[0]
        .attributes['src'];

    /* DESCRIPTION */
    String? description = document
        .getElementsByClassName("css-m8cbm1")[0].innerHtml.trim();

    /* PRICE */
    String? price ;
      price = document.getElementsByClassName("css-1g4pw3f")[0].innerHtml.split(" ")[0];

    /* Large Description */
    String? largeDescription =  document.getElementsByClassName("css-ivaahx")[0].text;


    var resultMap = {"shop": "www.auchan.ru", "image": imageUrl, "description": description, "price": price, "Описание": largeDescription};

    /*PROPERTIES*/
    var it = document.getElementsByTagName("tbody")[0].getElementsByTagName("tr");//[0].getElementsByClassName("sku-card-tab-params__item");
    it.forEach((prop) {
      String label = prop.getElementsByClassName("css-12mfum8")[0].innerHtml.trim();
      String val = prop.getElementsByClassName("css-2619sg")[0].innerHtml.trim();
      resultMap.addEntries([MapEntry(label, val)]);
    });
    return resultMap;
  }
}