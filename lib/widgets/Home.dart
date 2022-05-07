import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/Reader.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Column(children: [
          Expanded(child:
            ElevatedButton(
              onPressed: () { Navigator.push(context,
                MaterialPageRoute(builder: (context) {return Reader();}));
              },
              child: const Text(str_help_read)
          )),
          Expanded(child:
            ElevatedButton(
              onPressed: () { Navigator.push(context,
                  MaterialPageRoute(builder: (context) {return Reader();}));
              },
              child: const Text(str_help_search)
          ))
        ],)
    );
  }

}