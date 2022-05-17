import 'package:flutter/cupertino.dart';

import '../../resources/strings.dart';

class ProductHeader extends StatelessWidget {
  String name;
  String? manufacturer;
  String? price;
  String? weight;
  ProductHeader({Key? key, required this.name, this.manufacturer, this.price, this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        Row(
          children: [
            Column(
              children: [
                Text(manufacturer ?? str_manufacturer_not_found),
                Text(weight ?? "")
              ],
            ),
            Text(price ?? "")
          ],
        )
      ],
    );
  }
}
