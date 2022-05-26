import 'package:buy_vision_crossplatform/models/SearchPageViewModel.dart';
import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/search/ProductCard.dart';
import 'package:flutter/material.dart';

import '../../styles/TextStyles.dart';
import 'ProductCard.dart';
import 'SearchPage.dart';

class SearchList  extends StatelessWidget {
  SearchList ({Key? key, required this.search}) : super(key: key);
  SearchPageViewModel search;

  String getIconPath(String shop){
    switch(shop){
      case "Спар":
        return "https://contactgroup.ru/upload/iblock/6a8/6a830a1d942688b5f2e2f4470c692802.png";
      case "Лента":
        return "https://altekpro.ru/upload/iblock/4bf/4bfe11613d4cedb5d32ac8668756d7ff.png?resize=200x60";
      case "Ашан":
        return "https://i.siteapi.org/bvK3Lv-xaJ8DqzRT9hQtjPNeWqE=/fit-in/256x256/filters:fill(transparent):format(png)/s2.siteapi.org/d5d38a8c9499415/page/ga8c2d7hats84swcog4co4ww0wso4w";
        default:
        return "https://altekpro.ru/upload/iblock/4bf/4bfe11613d4cedb5d32ac8668756d7ff.png?resize=200x60";
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
        heroTag: "HEROTG",
        onPressed: () { Navigator.of(context).pop(); },
    child: Icon(Icons.navigate_before_outlined, size: 48)),
          appBar: AppBar(
            leading: Container(),
              title: Text(str_search_results, style: styleHeader)),
        body:
        (search.results.isEmpty) ?
       const Text(str_not_found)
   :
       ListView.separated(
         padding: EdgeInsets.symmetric(horizontal: 12),
         shrinkWrap: true,
         scrollDirection: Axis.vertical,
        itemCount: search.results.length,
        itemBuilder: (context, index) {
          return  ListTile(
              //i want to display different items for each list in the leading property.
                leading: Image.network(
                    getIconPath(search.results[index]['shop']!), width: 56,
                    height: 56),
                title: Text(search.results[index]['shop']!, style: styleHeadList),
                trailing: Text((search.results[index]['price'] ?? "-") + " RUB", style: styleHeadList),
                onTap: () =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          SearchPage(controller: search, index: index,)),
                    )
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 8,);
        },
      ));
    }
  }
