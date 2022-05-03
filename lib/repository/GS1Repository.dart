import '../models/ItemModel.dart';

class GS1Repository {
  static ItemModel? getInfo(gtin) {
    var result = ItemModel(name: "Ryazhenka Gorodeckaya");
    result.description = "molochnaya productia rayzhenka gorodeckaya 5 l";
    result.manufacturer = "Gorodecky molohni zavod";
    result.weight = "1";
    result.weightType = "l";
    return result;
  }
}
