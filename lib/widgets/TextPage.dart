import 'package:flutter/cupertino.dart';

class TextPage extends StatefulWidget{
  static String? text;
  @override
  State<StatefulWidget> createState() {
    return _TextPageState(text);
  }

}

class _TextPageState extends State<TextPage>{
  String? text;
  _TextPageState(this.text);
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        SingleChildScrollView(
          child: Text(
            text ?? "No text"
          ),
        )
    );
  }




}
