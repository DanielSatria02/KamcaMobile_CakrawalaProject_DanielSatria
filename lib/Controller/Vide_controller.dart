import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kamca_app/Controller/Header_controller.dart';
import 'package:kamca_app/Service/user_session.dart';
import 'package:kamca_app/View/Home_Page.dart';

class VidePageController {
  VidePageController({
    this.userName,
    this.profileImageAsset,
    this.capturedImagePath,
    HeaderController? headerController,
  }) : _headerController = headerController ?? HeaderController();

  final String? userName;
  final String? profileImageAsset;
  final HeaderController _headerController;
  String? capturedImagePath;

  String get _resolvedUserName => userName ?? KamcaSessionStore.instance.userName;

  String? get _resolvedProfileImageAsset => profileImageAsset ?? KamcaSessionStore.instance.profileImageAsset;

  HeaderController get headerController => _headerController;

  Widget? buildProfileImageWidget() {
    final String? asset = _resolvedProfileImageAsset;
    if (asset == null || asset.isEmpty) {
      return null;
    }

    return ClipOval(
      child: Image.asset(
        asset,
        width: 32,
        height: 32,
        fit: BoxFit.cover,
        gaplessPlayback: true,
      ),
    );
  }

  Future<void> updateCapturedImagePath(String? imagePath) async {
    capturedImagePath = imagePath;
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }

  Future<void> toggleHeaderPanel() async {
    await _headerController.togglePanel();
  }

  Future<void> closeHeaderPanel() async {
    await _headerController.closePanel();
  }

  Future<void> logout(BuildContext context) async {
    await _headerController.logout(context);
  }

  Future<void> backToHome(BuildContext context) async {
    if (!context.mounted) return;

    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomePage(
          userName: _resolvedUserName,
          profileImageAsset: _resolvedProfileImageAsset,
        ),
      ),
      (route) => false,
    );

    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}