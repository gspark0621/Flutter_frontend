import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    } else {
      _showSnackBar('카메라 권한이 필요합니다.');
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front, orElse: () => cameras.first);
    _cameraController = CameraController(frontCamera, ResolutionPreset.max, enableAudio: false);
    await _cameraController?.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('카메라 페이지'),
      ),
      body: CameraPreview(_cameraController!),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          await _takePictureAndSave();
        },
      ),
    );
  }

  Future<void> _takePictureAndSave() async {
    try {
      final image = await _cameraController!.takePicture();
      final directory = await getExternalStorageDirectory();
      final path = Directory('${directory!.path}/face_check').path;

      if (!await Directory(path).exists()) {
        await Directory(path).create(recursive: true);
      }

      final fileName = '${DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll(' ', '_')}.jpg';
      final fullPath = '$path/$fileName';
      await image.saveTo(fullPath);

      // 갤러리에 저장
      await GallerySaver.saveImage(fullPath, albumName: "face_check");

      _showSnackBar('사진이 갤러리에 저장되었습니다.');
    } catch (e) {
      _showSnackBar('사진 저장에 실패했습니다: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
