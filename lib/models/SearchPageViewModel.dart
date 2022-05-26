import 'package:buy_vision_crossplatform/repository/BarcodeList.dart';
import 'package:buy_vision_crossplatform/repository/GoogleSearch.dart';
import 'package:buy_vision_crossplatform/repository/ShopsSearcher.dart';

import '../resources/strings.dart';

class SearchPageViewModel{
  Map<String, String?>? currentResult;
  List<Map<String, String?>> results = [];
  List<String>? searchUrls;
  String? name;
  String code;

  SearchPageViewModel({required this.code});

  Future<String?> _getName(String code) async {
    return await BarcodeRepository.getInfo(code);
  }

  Future<List<String>?> _getSearchResults(String keyword) async {
    return await GoogleSearch.execute(keyword);
  }

  Future<Map<String, String?>?> _getMapFromUrl(String url) async{
    return await ShopSearcher.parse(url);
  }

  Future<List<Map<String, String?>>> getAllResults(String keyword) async {
    if (searchUrls!.isEmpty){
      return [];
    }
    List<Map<String, String?>> result = [];
    for (String url in searchUrls!){
      var t = await ShopSearcher.parse(url);
      if (t != null){
        result.add(t);
      }
    }
    return result;
  }

  // First screen data perpare and fill parameters
  Future<Map<String, String?>?> getScreenDetailsData({int? index}) async {
    if (this.name == null)
    {
      this.name = await _getName(code);
      if (this.name == null) {
        currentResult = {}; // Name was not found - empty map
      }
    }
    else {
      if (searchUrls == null || searchUrls!.isEmpty) {
        this.searchUrls = await _getSearchResults(name!);
      }

      // google does not search any info
      if (searchUrls == null || searchUrls!.isEmpty) {
        currentResult =
        {"shop": null, "name": name, "price": null, "image": null};
      }
      else {
        if (results.isEmpty) {
          for (String url in searchUrls!) {
            Map<String, String?>? t;
            try {
              t = await ShopSearcher.parse(url);
            }
            on Error {
              continue;
            }
            if (t != null && t != {}) {
              results.add(t);
            }
          }
        }

        // if we can not search info, just place name of product
        if (results.isEmpty) {
          currentResult =
          {"shop": null, "name": name, "price": null, "image": null};
        }
        else {
          index ??= 0;
          currentResult = results[index]; // all OK
        }
      }
    }
    return currentResult!;
  }


}