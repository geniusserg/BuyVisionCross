class ProductCard {
  String manufacturer;
  String productName;
  String gtin;
  String? shortDescription;
  DateTime date;

  ProductCard({
    required this.manufacturer,
    required this.productName,
    this.shortDescription,
    required this.gtin,
  }) : date = DateTime.now() {
    if (gtin.length < 12 || gtin.length > 13) {
      throw Exception("GTIN should contain 12 or 13 digits");
    }
  }
}
