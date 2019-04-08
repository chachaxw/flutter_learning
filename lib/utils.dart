import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

bool isDetecting = false;

Future<CameraDescription> getCamera(CameraLensDirection dir) async {
  return await availableCameras().then((List<CameraDescription> cameras) => cameras.firstWhere(
    (CameraDescription camera) => camera.lensDirection == dir
  ));
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

Future<FirebaseApp> getFirebaseApp() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'project-63604793957',
    options: const FirebaseOptions(
      googleAppID: '1:63604793957:ios:0f388d195373c0b9',
      apiKey: 'AIzaSyBvTuLK6V_jzbX8jd-sJDGPeG4CZNPOpb4',
      projectID: 'flutter-learning-1fd5c',
      gcmSenderID: '63604793957',
    ),
  );

  return app;
}