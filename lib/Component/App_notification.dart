import 'package:flutter/material.dart';
import 'package:kamca_app/Controller/Notification_controller.dart';
import 'package:kamca_app/Model/Notification_Model.dart';

class AppNotificationHost extends StatelessWidget {
  const AppNotificationHost({
    super.key,
    required this.controller,
  });

  final AppNotificationController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppNotificationModel?>(
      valueListenable: controller.activeNotification,
      builder: (context, notification, _) {
        final bool isVisible = notification != null;

        return IgnorePointer(
          ignoring: !isVisible,
          child: SafeArea(
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              offset: isVisible ? Offset.zero : const Offset(0, -0.25),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: isVisible ? 1 : 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: _NotificationCard(notification: notification),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final AppNotificationModel? notification;

  @override
  Widget build(BuildContext context) {
    if (notification == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            notification!.logoAssetPath,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
            gaplessPlayback: true,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              notification!.message,
              style: const TextStyle(
                color: Color.fromARGB(255, 25, 25, 25),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
                decorationColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}