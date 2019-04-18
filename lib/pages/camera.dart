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
      child: _cameraPreviewWidget(context),
    );
  }

  /// Display the preview from the camera
  Widget _cameraPreviewWidget(BuildContext context) {
    if (camera == null || !camera.value.isInitialized) {
      return Center(
        child: Text(
          'Open Camera',
          style: Theme.of(context).textTheme.display1,
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