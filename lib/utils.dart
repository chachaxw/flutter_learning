import 'package:meta/meta.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

bool isDetecting = false;

Future<CameraDescription> getCamera(CameraLensDirection dir) async {
  return await availableCameras().then((List<CameraDescription> cameras) => cameras.firstWhere(
    (CameraDescription camera) => camera.lensDirection == dir
  ));
}
