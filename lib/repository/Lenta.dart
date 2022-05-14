import 'dart:convert';

import '../models/ItemModel.dart';
import "package:http/http.dart" as http;
import 'package:html/parser.dart';

class GS1Repository {
  static Future<Map<String, dynamic>> getInfo(gtin) async {
    var response = await http.Client()
        .get(Uri.parse("https://srs.gs1ru.org/id/gtin/$gtin"));
    if (response.statusCode != 200) {
      throw Exception("Not found");
    }
    var document = parse(response.body);
    var image = document
        .getElementsByClassName("product-card__header-product-name")[0]
        .innerHtml
        .trim();
    var description = document
        .getElementsByClassName("product-card__header-company")[0]
        .innerHtml
        .trim();
    var price = document
        .getElementsByTagName("table")[1]
        .getElementsByTagName("tr")[2]
        .getElementsByClassName("text2")[0]
        .innerHtml
        .trim();
    var characteristics = document
        .getElementsByTagName("table")[1]
        .getElementsByTagName("tr")[3]
        .getElementsByClassName("text2")[0]
        .innerHtml
        .trim();
    return {"description": description, "price": price, "characteristics": characteristics};
  }
}