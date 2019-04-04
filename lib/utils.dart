import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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