import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:flutter/material.dart';

import '../../resources/strings.dart';
import 'ShowPhoto.dart';

class ProductCard extends StatelessWidget {
  Map<String, String>? properties; // properties from the first shop
  ProductCard({Key? key, required this.properties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = properties!['name'] ?? str_error;
    String price = properties!['price'] ?? str_price_not_found;
    String? image = properties!['image'];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Container(height: 15); // Define how to show a shop
          case 1:
            return Column(children: [
              Text(name, style: styleTextRecognized),
              Container(height: 15)
            ]);
          case 2:
            return Column(children: [
              Text(str_price + price, style: styleTextRecognized),
              Container(height: 10)
            ]);
          case 3:
            if (properties!['shop'] == "gs1.ru") {
              return Center(
                  child: Text(str_shop_not_found, style: styleWarning, textAlign: TextAlign.center));
            } else {
              return Column(children: [
                (image != null && image != "")
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ShowPicturePage(path: image)));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.black,
                                size: 36,
                              ),
                              Container(
                                height: 10,
                                width: 15,
                              ),
                              Text(
                                str_show_picture,
                                style: styleShortElementDescription,
                              )
                            ]))
                    : Divider(),
                Container(height: 30),
                Text(str_options, style: styleHeadList)
              ]);
            }
        }
        MapEntry<String, String> prop = properties!.entries.elementAt(index);
        return Column(
          children: [
            Text(prop.key, style: styleHeadList),
            Container(
              height: 8,
              width: 1,
            ),
            Text(prop.value, style: styleValueList),
            Divider()
          ],
        );
      },
      itemCount: properties!.length,
    );
  }
}
