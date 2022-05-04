import 'dart:collection';
import 'dart:convert';

import 'package:html/dom.dart';

import '../models/ItemModel.dart';
import "package:http/http.dart" as http;
import 'package:html/parser.dart';


class NationalCatalogRepository {
  static Future<ItemModel?> getInfo(gtin) async {
    var response = await http.Client().get(Uri.parse("https://xn----7sbabas4ajkhfocclk9d3cvfsa.xn--p1ai/search/?q=$gtin&type=goods"));
    if (response.statusCode != 200){
      throw Exception("Internet error");
    }
    var document = parse(response.body, encoding: "utf-8");
    var resultSearch = document.getElementsByClassName("catalog__grid-view");
    Map<String, String> productAttributes = HashMap();
    String? image;
    print(resultSearch[0]);
    if (resultSearch.length > 0){
      var cardlink = resultSearch[0].getElementsByTagName("a")[0].attributes['href'] as String?;
      if (cardlink != null){
        var response = await http.Client().get(Uri.parse(cardlink));
        var document = parse(response);
        image = document.getElementsByTagName("img")[0].attributes['src'];
        for (var tab in document.getElementsByClassName("tab-section")){
          var header = tab.getElementsByClassName("tab-section__heading");
          if (header.isEmpty){continue;}
          var headerText = header[0].innerHtml.trim();
          if (headerText.contains("Нормативно-сопроводительная документация")
              || headerText.contains("Данные для ФГИС ВетИС")){continue;}
          for (var attr in tab.getElementsByTagName("tr")){
            var attrKey = attr.getElementsByTagName("th")[0].innerHtml.trim();
            var attrVal = attr.getElementsByTagName("td")[0].innerHtml.trim();
            productAttributes[attrKey] = attrVal;
          }
        }
      }

      String? name;
      if (productAttributes.containsKey("Товарный знак")){
        name = productAttributes["Товарный знак"];
      }
      else if (productAttributes.containsKey("Полное наименование товара")){
        name = productAttributes["Полное наименование товара"];
      }
      else{
        throw Exception("Error while parsing");
      }
      return ItemModel(name: name!)
        ..description=productAttributes["Полное наименование товара"]
          ..largePhoto=image
            ..options=productAttributes;
    }
    else{
      throw Exception("Not found :(");
    }
  }
}