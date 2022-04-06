import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:async';
import '../models/product_card.dart';

void printItemInfo(ProductCard? item) {
  if (item == null) {
    print("Item was not found in the system");
  } else {
    print("Get result. Date: " + item.date.toString());
    print("GTIN: " + item.gtin);
    print("Manufacturer: " + item.manufacturer);
    print("Name: " + item.productName);
    print("Short description: " + (item.shortDescription ?? "..."));
  }
}

class RepositoryGS1 {
  static const String gs1Address = "https://srs.gs1ru.org/id/gtin";

  Future<ProductCard?> getInfoByGTIN(String gtinID) async {
    var searchAdress = "$gs1Address/$gtinID";
    print("get product info from $searchAdress");
    var res = await http.get(Uri.parse(searchAdress));
    if (res.statusCode == 200) {
      var document = parse(res.body);
      var manufacturer = document
          .getElementsByClassName("product-card__header-company")[0]
          .innerHtml
          .trim();

      var short_description = document
          .getElementsByClassName("product-card__header-product-name")[0]
          .innerHtml
          .trim();

      var weight = document
          .getElementsByTagName("table")[1]
          .getElementsByTagName("tbody")[0]
          .getElementsByTagName("tr")[3]
          .getElementsByTagName("td")[0]
          .getElementsByClassName("text2")[0]
          .innerHtml
          .trim();

      var brand = document
          .getElementsByTagName("table")[1]
          .getElementsByTagName("tbody")[0]
          .getElementsByTagName("tr")[2]
          .getElementsByTagName("td")[0]
          .getElementsByClassName("text2")[0]
          .innerHtml
          .trim();

      var card = ProductCard(
          gtin: gtinID,
          manufacturer: manufacturer,
          productName: brand,
          shortDescription: short_description);
      return card;
    } else {
      return null;
    }
  }
}
