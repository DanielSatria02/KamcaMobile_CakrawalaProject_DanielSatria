import 'package:flutter/foundation.dart';
import 'package:kamca_app/Model/Notification_Model.dart';

class AppNotificationController {
  AppNotificationController._();

  static final AppNotificationController shared = AppNotificationController._();

  final ValueNotifier<AppNotificationModel?> _activeNotification = ValueNotifier<AppNotificationModel?>(null);
  int _requestId = 0;

  ValueListenable<AppNotificationModel?> get activeNotification => _activeNotification;

  Future<void> show(AppNotificationModel notification) async {
    final int currentRequestId = ++_requestId;
    _activeNotification.value = notification;

    await Future<void>.delayed(notification.duration);
    if (currentRequestId != _requestId) return;

    _activeNotification.value = null;
  }

  Future<void> showLoginSuccess() async {
    await show(
      const AppNotificationModel(
        message: 'You have successfully logged in',
        logoAssetPath: 'assets/KamcaLogo.png',
      ),
    );
  }

  Future<void> dismiss() async {
    ++_requestId;
    _activeNotification.value = null;
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }

  void dispose() {
    _activeNotification.dispose();
  }
}