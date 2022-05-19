import "package:http/http.dart" as http;
import 'package:html/parser.dart';

import 'Shop.dart';

class Auchan implements Shop{
  @override
  Future<Map<String, String?>> execute(String url) async {
    var response = await http.Client()
        .get(Uri.parse(url), headers: {
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36 Edg/101.0.1210.39",
          "Cookie": "mindboxDeviceUUID=317e5716-e3ef-46a4-b424-cda9ac1981aa; directCrm-session=%7B%22deviceGuid%22%3A%22317e5716-e3ef-46a4-b424-cda9ac1981aa%22%7D; tmr_lvid=96ed3bf98828b971bfeb3417322538fb; tmr_lvidTS=1650267391292; isAddressPopupShown_=true; region_id=1; merchant_ID_=1; methodDelivery_=1; _GASHOP=001_Mitishchi; _ym_uid=1650267393544306546; _ym_d=1650267393; rrpvid=566790918484082; rcuid=625d15039ad0b80001e911cb; qrator_jsr=1652965795.956.LoHupt8OvL0Z60Y2-arj1qlcl5o19p2bodltueqkk3edm8gmu-00; qrator_ssid=1652965797.583.oVDswufHlreogtCj-99h6v8g29dtflk66crv6r0bb413i7dkt; qrator_jsid=1652965795.956.LoHupt8OvL0Z60Y2-q5ql45rdntt3bcnvfeqhnfotkh84kelo; rr-viewItemId=830811; rrviewed=830811; _ym_isad=2; rrlevt=1652965806877; tmr_detect=0%7C1652965815517; tmr_reqNum=161"
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