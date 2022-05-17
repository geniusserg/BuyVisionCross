import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/search/ProductCard.dart';
import 'package:flutter/material.dart';

import 'ProductCard.dart';

class SearchList  extends StatelessWidget {
  SearchList ({Key? key, this.results}) : super(key: key);
  List<Map<String, dynamic>>? results;

  String getIconPath(String shop){
    switch(shop){
      case "spar":
        return "https://contactgroup.ru/upload/iblock/6a8/6a830a1d942688b5f2e2f4470c692802.png";
      case "lenta":
        return "https://altekpro.ru/upload/iblock/4bf/4bfe11613d4cedb5d32ac8668756d7ff.png?resize=200x60";
      default:
        return "https://altekpro.ru/upload/iblock/4bf/4bfe11613d4cedb5d32ac8668756d7ff.png?resize=200x60";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (results == null) {
      return const Text(str_not_found);
    }
    else {
      return ListView.separated(
        itemCount: results!.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              //i want to display different items for each list in the leading property.
                leading: Image.network(
                    getIconPath(results![index]['shop']), width: 20,
                    height: 20),
                title: Text(results![index]['name']),
                onTap: () =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          ProductCard(
                              properties: results![index]['properties'])),
                    )
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      );
    }
  }
}
