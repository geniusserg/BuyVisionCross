import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:http/http.dart';
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
    var res = await getSearchPage(gtinID);
    if (res.statusCode != 200) {
      throw Exception("Item $gtinID was not found");
    }
    var document = parse(res.body);
    var manufacturer = getManufacturer(document);
    var short_description = getShortDescription(document);
    var brand = getProductName(document);
    var card = ProductCard(
        gtin: gtinID,
        manufacturer: manufacturer,
        productName: brand,
        shortDescription: short_description);
    return card;
  }

  Future<Response> getSearchPage(String gtin) async {
    var searchAdress = "$gs1Address/$gtin";
    print("get product info from $searchAdress");
    var res = await http.get(Uri.parse(searchAdress));
    return res;
  }

  String getManufacturer(Document document) {
    return document
        .getElementsByClassName("product-card__header-company")[0]
        .innerHtml
        .trim();
  }

  String getShortDescription(Document document) {
    return document
        .getElementsByClassName("product-card__header-product-name")[0]
        .innerHtml
        .trim();
  }

  String getProductName(Document document) {
    return document
        .getElementsByTagName("table")[1]
        .getElementsByTagName("tbody")[0]
        .getElementsByTagName("tr")[2]
        .getElementsByTagName("td")[0]
        .getElementsByClassName("text2")[0]
        .innerHtml
        .trim();
  }
}
