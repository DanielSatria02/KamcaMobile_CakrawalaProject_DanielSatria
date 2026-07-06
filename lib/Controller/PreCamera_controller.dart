import 'package:flutter/material.dart';
import 'package:kamca_app/View/Home_Page.dart';
import 'package:kamca_app/View/Camera_Page.dart';
import 'package:kamca_app/Service/user_session.dart';

class PreCameraController {
  const PreCameraController({
    this.userName,
    this.profileImageAsset,
  });

  final String? userName;
  final String? profileImageAsset;

  String get _resolvedUserName => userName ?? KamcaSessionStore.instance.userName;

  String? get _resolvedProfileImageAsset => profileImageAsset ?? KamcaSessionStore.instance.profileImageAsset;

  Future<void> disagreeAndGoToHome(BuildContext context) async {
    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
      (route) => false,
    );

    await Future<void>.delayed(const Duration(milliseconds: 1));
  }

  Future<void> agreeAndContinue(BuildContext context) async {
    if (!context.mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CameraPage(
          userName: _resolvedUserName,
          profileImageAsset: _resolvedProfileImageAsset,
        ),
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}
