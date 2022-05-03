class ItemModel {
  String name;
  String? manufacturer;
  String? weight;
  String? weightType;
  String? description;

  String? largePhoto;
  String? price;
  Map<String, String>? options;

  ItemModel({required this.name});
  @override
  String toString() {
    return "{ name: '$name', parameters: ['$manufacturer', '$weight$weightType', '$description']}";
  }
}
