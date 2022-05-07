import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reader extends StatelessWidget {
  String? imageUrl;
  Reader({Key? key, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
      child: imageUrl == null
          ? Column(children: [
              Image.network(imageUrl!),
              FloatingActionButton(onPressed: () {})
            ])
          : const Icon(Icons.not_accessible),
    ));
  }
}
