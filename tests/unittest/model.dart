import 'package:buy_vision_crossplatform/models/product_card.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Create data model objects", () {
    test("ProductCard model", () {
      ProductCard(
          gtin: "0000000000000", manufacturer: "Apple", productName: "MacBook");
      ProductCard(
          gtin: "0000000000000",
          manufacturer: "Apple",
          productName: "MacBook",
          shortDescription: "computer");
    });
    test("Product with gtin less 12", () {
      try {
        ProductCard(manufacturer: "0", productName: "n", gtin: "0");
      } on Exception catch (e) {
        expect(e.toString().length, predicate((int x) => x > 0));
      }
    });
  });
}
