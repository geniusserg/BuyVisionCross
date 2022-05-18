import 'package:buy_vision_crossplatform/repository/BarcodeList.dart';
import 'package:buy_vision_crossplatform/repository/GS1Repository.dart';
import 'package:buy_vision_crossplatform/repository/GoogleSearch.dart';
import 'package:buy_vision_crossplatform/repository/Lenta.dart';

Future<void> main() async{
  String gtin = "4605922011859";
  //print(await BarcodeRepository.getInfo(gtin));
  //String? product = await BarcodeRepository.getInfo(gtin);
  //print(await GS1Repository.getInfo(gtin));
  //if (product != null){print(await GoogleSearch.execute(product));}
  print(await Lenta().execute("https://lenta.com/product/desert-molochnyjj-chudo-past-vzbityjj-s-tvor-krem-frukt-tvorozhok-persgrush-42-rossiya-100g-006100/"));
}