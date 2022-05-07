import 'package:buy_vision_crossplatform/resources/strings.dart';
import 'package:buy_vision_crossplatform/widgets/Preview.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CameraScreen();
                  }));
                },
                child: const Text(str_help_read))),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CameraScreen();
                  }));
                },
                child: const Text(str_help_search)))
      ],
    ));
  }

  Widget buildCameraError(BuildContext context) {
    return Column(children: [
      Icon(Icons.flip_camera_ios, color: Colors.red),
      Text(str_camera_error)
    ]);
  }
}
