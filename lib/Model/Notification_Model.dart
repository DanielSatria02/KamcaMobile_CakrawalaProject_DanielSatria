class AppNotificationModel {
  final String message;
  final String logoAssetPath;
  final Duration duration;

  const AppNotificationModel({
    required this.message,
    required this.logoAssetPath,
    this.duration = const Duration(seconds: 3),
  });
}