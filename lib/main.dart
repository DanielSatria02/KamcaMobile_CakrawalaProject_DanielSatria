import 'package:flutter/material.dart';
import 'package:kamca_app/Login_Page.dart';

void main() {
  runApp(const KamcaApp());
}


class KamcaApp extends StatelessWidget {
  const KamcaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamca App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const KamcaBackgroundScreen(),
    );
  }
}