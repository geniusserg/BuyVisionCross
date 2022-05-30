import 'package:buy_vision_crossplatform/di/dependencies.dart';
import 'package:buy_vision_crossplatform/widgets/TextPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final CameraController _controller;

  void _initializeCamera() {
    final CameraController cameraController = CameraController(
    cameraDescription!, // should be resolved in main!
      ResolutionPreset.max,
    );
    _controller = cameraController;

    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<String?> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    String? imagePath;
    if (_controller.value.isTakingPicture) {
      return null;
    }
    try {
      _controller.setFlashMode(FlashMode.always);
      final XFile file = await _controller.takePicture();
      imagePath = file.path;
    } on CameraException catch (e) {
      return null;
    }

    return imagePath;
  }

  Future<void> handleTakingPicture() async {
    await _takePicture().then((String? path) {
        //_controller.dispose(); // maybe issue here?
        if (path != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TextPage(path: path),
            ),
          );
        }
    });
  }

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    // dispose the camera controller when navigated
    // to a different page
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROTAG",
        onPressed: () { Navigator.of(context).pop(); },
        child: Icon(Icons.navigate_before_outlined, size: 48),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: _controller.value.isInitialized
          ? Stack(
              children: <Widget>[
                CameraPreview(_controller),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton.large(
                      child: Icon(Icons.photo_camera, size: 42),
                      onPressed: handleTakingPicture
                    ),
                  ),
                )
              ],
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}

