import 'package:buy_vision_crossplatform/repository/Auchan.dart';
import 'package:buy_vision_crossplatform/repository/BarcodeList.dart';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/repository/GoogleSearch.dart';
import 'package:buy_vision_crossplatform/repository/Lenta.dart';

Future<void> main() async{
  String gtin = "4605922011859";
  //print(await BarcodeRepository.getInfo(gtin));
  String? product = await BarcodeRepository.getInfo(gtin);
  if (product != null){
    List<String> urls = [];
    urls = await GoogleSearch.execute(product);
    print(await Lenta().execute(urls[0]));
    print(await Auchan().execute(urls[2]));
  }

}