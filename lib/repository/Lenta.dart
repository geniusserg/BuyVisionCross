
import 'dart:developer';

import "package:http/http.dart" as http;
import 'package:html/parser.dart';

import 'Shop.dart';

class Lenta implements Shop{
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


    var resultMap = {"shop": "lenta.com", "image": imageUrl, "description": description, "price": price};

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