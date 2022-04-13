class ItemModel {
  String headerName;
  String? fullName;
  double? weight;
  String? weightType;
  String? manufacturer;
  String? country;
  String? description;
  String? components;
  String? price;
  Map<String, String>? commonInformation;
  String largePhoto;
  String? minPhoto;

  ItemModel({required this.headerName, required this.largePhoto});
}
