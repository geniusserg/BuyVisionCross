import 'package:flutter/material.dart';

import '../../resources/strings.dart';

class ShowPicturePage extends StatelessWidget {
  String path;
  ShowPicturePage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: GestureDetector(child:Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(12),
          child: Image.network(
      path,
      semanticLabel: str_label_photo,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
      },
          ),
        ),
        onTap: () {
    Navigator.of(context).pop();
    },
        ),
    floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.of(context).pop();
    },
    child: Icon(Icons.navigate_before)));
  }
}
