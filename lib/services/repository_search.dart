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
  
}
