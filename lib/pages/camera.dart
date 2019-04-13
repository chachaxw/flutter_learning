import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraExample extends StatefulWidget {
  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  CameraController camera;
  String imagePath;
  String videoPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _cameraPreviewWidget(),
    );
  }

  /// Display the preview from the camera
  Widget _cameraPreviewWidget() {
    if (camera == null || !camera.value.isInitialized) {
      return const Center(
        child: Text(
          'Open Camera',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: camera.value.aspectRatio,
        child: CameraPreview(camera),
      );
    }
  }
}