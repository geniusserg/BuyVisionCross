import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reader extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ReaderState();
  }
}

class _ReaderState extends State<Reader>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
        child: Image.network(
            "https://imgproxy.sbermarket.ru/imgproxy/size-1646-1646/aHR0cHM6Ly9z"
                "YmVybWFya2V0LnJ1L3NwcmVlL3Byb2R1Y3RzLzE2MDczMDMvb3JpZ2luYWwvMTk"
                "1OTVfMS5qcGc_MTY0MDAwOTY4Nw.png")));
  }
}