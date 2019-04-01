import 'utils.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';

List<CameraDescription> cameras;

class FaceExpressionReader extends ValueNotifier<Face> {
  FaceExpressionReader() : super(null) {
    init();
  }

  CameraLensDirection dir = CameraLensDirection.back;
  CameraController camera;
  FaceDetector decetor;

  void init() async {
    camera = CameraController(await getCamera(dir), ResolutionPreset.medium);
    await camera.initialize();

    decetor = FirebaseVision.instance.faceDetector(FaceDetectorOptions(
      enableClassification: true,
      mode: FaceDetectorMode.accurate
    ));
  }
}