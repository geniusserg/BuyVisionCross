class ItemModel {
  var id;
  var text;
  var photo;
  var date;
  var barcode;

  ItemModel(
      {required this.id,
      required this.text,
      required this.date,
      required this.photo,
      this.barcode});
}
