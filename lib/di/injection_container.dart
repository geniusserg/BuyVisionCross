import 'package:buy_vision_crossplatform/services/FirebaseRecognitionService.dart';
import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import '../services/get_camera.dart';

// This function builds tree of dependencies using GetIt
// To get instance in code use getIt();

final getIt = GetIt.instance;

Future<void> init() async {
    //CameraDescription camera = await initCamera();
    //getIt.registerSingleton<CameraDescription>(camera);
    getIt.registerLazySingleton<FirebaseRecognitionService>(() => FirebaseRecognitionService());
}