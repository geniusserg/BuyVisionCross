
import 'package:buy_vision_crossplatform/models/ItemModel.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'dart:async';
import '../models/product_card.dart';

void printItemInfo(ItemModel? item) {
  
}

class RepositorySberMarket {
  static const String sbermarketAddress = "https://sbermarket.ru/auchan/";
  Future<ItemModel?> getCardsByKeyword(String searchKeyword) async {
    var res = await getSearchResults(searchKeyword);
    if (res.statusCode != 200) {
      throw Exception("Item with key words $searchKeyword was not found");
    }
    var document = parse(res.body);
    var manufacturer = getManufacturer(document);
    var short_description = getShortDescription(document);
    var brand = getProductName(document);
    return null;
  }

  Future<Response> getSearchResults(String searchKeyword) async {
    var searchAdress = "$sbermarketAddress/search?keywords=$searchKeyword";
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
