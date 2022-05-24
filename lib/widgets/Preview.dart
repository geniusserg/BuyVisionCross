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

  // Initializes camera controller to preview on screen
  void _initializeCamera() {
    final CameraController cameraController = CameraController(
    cameraDescription!, // should be resolved in main!
      ResolutionPreset.high,
    );
    _controller = cameraController;

    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  // Takes picture with the selected device camera, and
  // returns the image path
  Future<String?> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return null;
    }

    String? imagePath;

    if (_controller.value.isTakingPicture) {
      return null;
    }

    try {
      // Turning off the camera flash
      _controller.setFlashMode(FlashMode.off);
      // Returns the image in cross-platform file abstraction
      final XFile file = await _controller.takePicture();
      // Retrieving the path
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
          Navigator.push(
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
        heroTag: "HEROTG",
        onPressed: () { Navigator.of(context).pop(); },
        child: Icon(Icons.navigate_before_outlined),
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
                      child: Icon(Icons.photo_camera),
                      onPressed: handleTakingPicture
                    ),
                  ),
                )
              ],
            )
          : Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}

