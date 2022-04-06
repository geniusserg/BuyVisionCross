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
  }) : date = DateTime.now();
}
