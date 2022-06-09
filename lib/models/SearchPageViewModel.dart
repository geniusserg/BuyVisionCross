import 'package:buy_vision_crossplatform/repository/BarcodeList.dart';
import 'package:buy_vision_crossplatform/repository/GoogleSearch.dart';
import 'package:buy_vision_crossplatform/repository/ShopsSearcher.dart';

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
   var res = await GoogleSearch.execute(keyword);
   if (res.length > 3){
     res.removeRange(3, res.length);
   }
   return res;
  }

  Future<List<Map<String, String?>>> _getAllResults(String keyword) async {
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

  Future<Map<String, String?>?> _getFirstResult(String keyword) async {
    if (searchUrls!.isEmpty){
      return null;
    }
    for (String url in searchUrls!){
      var t = await ShopSearcher.parse(url);
      if (t != null){
        return t;
      }
    }
    return null;
  }

  Future<List<Map<String, String?>>> getListScreenData() async{
    if (results.isEmpty) {
      results = await _getAllResults(name!);
    }
    return results;
  }

  // First screen data perpare and fill parameters
  Future<Map<String, String?>?> getScreenDetailsData({int? index}) async {
    currentResult = {};
    name ??= await _getName(code);
    index ??= 0;

    if (name != null) {
      if (searchUrls == null || searchUrls!.isEmpty) {
        searchUrls = await _getSearchResults(name!);
      }

      // google does not search any info
      if (searchUrls == null || searchUrls!.isEmpty) {
        currentResult =
        {"shop": null, "name": name, "price": null, "image": null};
      }
      else {
          if (index == 0){
            if (results.isNotEmpty){
              currentResult = results[index];
            }
            // QUICKLY LOAD FIRST INFO!
            else {
              var firstResult = await _getFirstResult(
                  name!); // to make loading fast parse just first
              if (firstResult == null) {
                currentResult =
                {"shop": null, "name": name, "price": null, "image": null};
              }
              else {
                currentResult = firstResult;
              }
            }
          }
          else{
            currentResult = results[index];
          }
      }
    }
    else{
      currentResult = {};
    }
    return currentResult!;
  }

}