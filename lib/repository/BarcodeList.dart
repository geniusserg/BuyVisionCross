import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' ;
import 'package:http/http.dart';

class BarcodeRepository {
  static Future<String?> getInfo(String gtin) async {
    var response = await Client().get(Uri.parse(
        "https://barcode-list.ru/barcode/RU/%D0%9F%D0%BE%D0%B8%D1%81%D0%BA.htm?barcode=$gtin"));
    if (response.statusCode != 200) {
      throw Exception("Not found");
    }
    List<dom.Element> barcodeDescription = parse(response.body)
        .getElementsByClassName("randomBarcodes");
    if (barcodeDescription.isEmpty){
      return null;
    }
    String barcodeDescriptionString = barcodeDescription[0]
        .getElementsByTagName("tbody")[0]
        .getElementsByTagName("tr")[1]
        .getElementsByTagName("td")[2]
        .innerHtml
        .trim();
    return barcodeDescriptionString;
  }
}
