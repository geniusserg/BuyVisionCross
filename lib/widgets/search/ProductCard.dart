import 'package:buy_vision_crossplatform/styles/TextStyles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  Map<String, String> properties;
  ProductCard( {Key? key, required this.properties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(properties['name']!),
    ListView.separated(
    itemBuilder: (context, index) {
    MapEntry<String, String> prop = properties.entries.elementAt(index);
    return Column(
    children: [
    Text(prop.key, style: styleHeadList),
    Text(prop.value, style: styleValueList)
    ],
    );
    },
    separatorBuilder: (context, index) {
    return const Divider();
    },
      itemCount: properties.length,
    )
    ],);

  }
}
