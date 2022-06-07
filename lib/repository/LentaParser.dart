
import 'dart:developer';

import "package:http/http.dart" as http;
import 'package:html/parser.dart';

import 'ShopParser.dart';

class LentaParser implements ShopParser{
  @override
  Future<Map<String, String?>?> execute(String url) async {
    var response = await http.Client()
        .get(Uri.parse(url), headers: {
      "Connection": "keep-alive",
      "Cookie":  " mindboxDeviceUUID=317e5716-e3ef-46a4-b424-cda9ac1981aa; directCrm-session=%7B%22deviceGuid%22%3A%22317e5716-e3ef-46a4-b424-cda9ac1981aa%22%7D; tmr_lvid=96ed3bf98828b971bfeb3417322538fb; tmr_lvidTS=1650267391292; isAddressPopupShown_=true; region_id=1; merchant_ID_=1; methodDelivery_=1; _GASHOP=001_Mitishchi; _ym_uid=1650267393544306546; _ym_d=1650267393; rrpvid=566790918484082; rcuid=625d15039ad0b80001e911cb; _ym_isad=2; rr-viewItemId=299515; rrviewed=299515; qrator_jsid=1653598728.540.do7qhu7l8CDdaKke-6peptbfvpdkl8srpq3nanjbab1c8dkdd; tmr_detect=0%7C1653599097088; rrlevt=1653599098625; tmr_reqNum=229",
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36",
    });
    if (response.statusCode != 200) {
      throw Exception("Not found");
    }
    var document = parse(response.body);

    /* IMAGE */
    var imageUrl = document
        .getElementsByTagName("img")[1]
        .attributes['src'];

    /* DESCRIPTION */
    String? description;
    var descriptionElement = document
        .getElementsByClassName("sku-card__title");
    if (descriptionElement.isEmpty){
    descriptionElement = document
        .getElementsByClassName("sku-page__title");
    }
    if (descriptionElement.isEmpty){
      description = null;
    }
    description = descriptionElement[0].innerHtml.trim();

    /* PRICE */
    String? price ;
    var priceElement = document.getElementsByClassName("price__primary");
    if (priceElement.isEmpty) {
      priceElement = document.getElementsByClassName("price-label__integer");
      if (priceElement.isNotEmpty){
        price = [priceElement[0].innerHtml.trim(), document.getElementsByClassName("price-label__fraction")[0].innerHtml.trim()].join(',');
      }
      else{
        price = null;
      }
    }
    else{
      price = document
          .getElementsByClassName("price__primary")[0]
          .innerHtml
          .replaceAll("<small>", "")
          .replaceAll("</small>", "")
          .replaceAll(" ", "")
          .replaceAll("\n", "");
    }


    var resultMap = {"shop": "Лента", "name": description, "image": imageUrl, "price": price};

    /*PROPERTIES*/
    var it = document.getElementsByClassName("sku-card-tab-params__item");//[0].getElementsByClassName("sku-card-tab-params__item");
    it.forEach((prop) {
      String label = prop.getElementsByClassName("sku-card-tab-params__label")[0].innerHtml.trim();
      var valueElement = prop.getElementsByClassName("sku-card-tab-params__value");
      if (valueElement.isEmpty){
        valueElement = prop.getElementsByTagName("a");
      }
      String val = valueElement[0].innerHtml.trim();
      resultMap.addEntries([MapEntry(label, val)]);
    });
    return resultMap;
  }
}