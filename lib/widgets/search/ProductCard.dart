import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:flutter/material.dart';

import '../../resources/strings.dart';
import 'ShowPhoto.dart';

class ProductCard extends StatelessWidget {
  Map<String, String>? properties; // properties from the first shop
  ProductCard( {Key? key, required this.properties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (properties == null){
      return  Center(child: Text(str_shop_not_found, style: styleTextRecognized));
    }

    String name = properties!['name'] ?? str_error;
    String price = properties!['price'] ?? str_price_not_found;
    String? image = properties!['image'];

    return Scaffold(body:
      SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
            switch(index){
              case 0:
                return Column(children:[Text(name, style: styleTextRecognized), Container(height: 10)]);
              case 1:
                return Column(children:[Text(str_price+price, style: styleTextRecognized), Container(height: 10)]);
              case 2:
                return Column(children:[ image != null ?
                TextButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowPicturePage(path: image)));
                }, child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children:[
                  Icon(Icons.image_outlined, color: Colors.black, size: 36,),
                  Container(height: 10, width: 15,),
                  Text(str_show_picture, style: styleShortElementDescription,)])) : Divider(), Container(height: 20)]);
            }
            MapEntry<String, String> prop = properties!.entries.elementAt(index);
            return Column(
              children: [
                Text(prop.key, style: styleHeadList),
                Container(height: 8, width: 1,),
                Text(prop.value, style: styleValueList),
                Divider()
              ],
            );


          },

      itemCount: properties!.length,
    )),
    );

  }
}
