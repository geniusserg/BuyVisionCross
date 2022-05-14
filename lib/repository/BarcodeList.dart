import 'package:html/parser.dart';
import 'package:http/http.dart';

class BarcodeRepository {
  static Future<String> getInfo(gtin) async {
    var response = await Client().get(Uri.parse(
        "https://barcode-list.ru/barcode/RU/%D0%9F%D0%BE%D0%B8%D1%81%D0%BA.htm?barcode=$gtin"));
    if (response.statusCode != 200) {
      throw Exception("Not found");
    }
    var document = parse(response.body);
    var barcodeDescription = document
        .getElementsByClassName("randomBarcodes")[0]
        .getElementsByTagName("tbody")[0]
        .getElementsByTagName("tr")[1]
        .getElementsByTagName("td")[2]
        .innerHtml
        .trim();

    return barcodeDescription;
  }
}
