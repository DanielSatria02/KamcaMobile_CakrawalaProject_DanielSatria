import 'package:flutter/material.dart';
import 'package:kamca_app/Component/App_notification.dart';
import 'package:kamca_app/Controller/Notification_controller.dart';
import 'package:kamca_app/Service/user_session.dart';
import 'package:kamca_app/View/Home_Page.dart';
import 'package:kamca_app/View/Login_Page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KamcaSessionStore.instance.init();
  runApp(const KamcaApp());
}

class KamcaApp extends StatefulWidget {
  const KamcaApp({super.key});

  @override
  State<KamcaApp> createState() => _KamcaAppState();
}

class _KamcaAppState extends State<KamcaApp> {
  late final AppNotificationController _notificationController;

  @override
  void initState() {
    super.initState();
    _notificationController = AppNotificationController.shared;
  }

  @override
  Widget build(BuildContext context) {
    final Widget homeScreen = KamcaSessionStore.instance.isLoggedIn
        ? const HomePage()
        : KamcaBackgroundScreen(notificationController: _notificationController);

    return MaterialApp(
      title: 'Kamca App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            AppNotificationHost(controller: _notificationController),
          ],
        );
      },
      home: homeScreen,
    );
  }
}