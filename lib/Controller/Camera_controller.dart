import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermissionDeniedException implements Exception {
  const CameraPermissionDeniedException({required this.permanentlyDenied});

  final bool permanentlyDenied;
}

class KamcaCameraController {
  const KamcaCameraController();

  Future<CameraController?> initializeFrontCamera() async {
    if (_shouldRequestRuntimePermission) {
      final PermissionStatus requestedStatus = await _requestCameraPermission();
      if (!requestedStatus.isGranted) {
        throw CameraPermissionDeniedException(
          permanentlyDenied: requestedStatus.isPermanentlyDenied,
        );
      }
    }

    final List<CameraDescription> available = await availableCameras();

    if (available.isEmpty) {
      return null;
    }

    final CameraDescription selected = available.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => available.first,
    );

    final CameraController controller = CameraController(
      selected,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await controller.initialize();
    return controller;
  }

  Future<void> openPermissionSettings() async {
    await openAppSettings();
  }

  Future<PermissionStatus> _requestCameraPermission() async {
    final PermissionStatus current = await Permission.camera.status;
    if (current.isGranted) {
      return current;
    }

    return Permission.camera.request();
  }

  bool get _shouldRequestRuntimePermission {
    if (kIsWeb) {
      return false;
    }

    return defaultTargetPlatform != TargetPlatform.windows;
  }
}
