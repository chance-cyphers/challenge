import 'dart:io';

import 'package:camera/camera.dart';
import 'package:challenge_app/device_storage.dart';
import 'package:challenge_app/gcloud.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  String _videoPath;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          print("not mounted");
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      print("error recording");
      return null;
    }
    if (controller.value.isRecordingVideo) {
      return null;
    }

    final Directory extDir = await getTemporaryDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$dirPath/$timestamp.mp4';

    try {
      _videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print("camera exception: $e");
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
      var file = await deviceStorage.getTempFile(_videoPath);
      uploadFile(file, "aVideo");
    } on CameraException catch (e) {
      print("camera exception: $e");
      return null;
    }
  }

  void _onPress() {
    if (controller.value.isRecordingVideo) {
      stopVideoRecording();
    } else {
      startVideoRecording();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller)),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPress,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
