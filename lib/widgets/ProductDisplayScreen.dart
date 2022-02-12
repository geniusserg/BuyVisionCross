import 'dart:io';
import 'package:buy_vision_crossplatform/models/ItemModel.dart';
import 'package:flutter/material.dart';

class ProductDisplayScreen extends StatelessWidget {
  late final date;
  late final image;
  late final text;
  late final barcode;

  ProductDisplayScreen({required ItemModel model}) {
    this.date = model.date;
    this.image = model.photo;
    this.text = model.text;
    this.barcode = model.barcode ?? "No barcode";
  }

  // build title with product name
  Widget _buildTitle({required String text}) => Container(
      padding: const EdgeInsets.all(32),
      child: Row(children: [
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(text,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(text, style: TextStyle(color: Colors.grey[500]))
        ])),
        Icon(Icons.star, color: Colors.red[500]),
        const Text('42'),
      ]));

  Widget _buildButton(
          {required String label,
          required IconData icon,
          required Color color}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
              child: Text(label,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w400, fontSize: 12)))
        ],
      );

  var buttonsList = {
    "Купить": Icons.shop,
    "Подробнее": Icons.search,
    "Срок годности": Icons.lock_clock
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.file(
          File(image),
        ),
        _buildTitle(text: "Ряженка 100л"),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: buttonsList.entries
                .map((button) => _buildButton(
                    label: button.key,
                    icon: button.value,
                    color: Colors.red[500]!))
                .toList()),
        Text("Text: "+text+"\nBARCode:\n"+barcode, style: const TextStyle(fontSize: 23)),
      ],
    );
  }
}
