import 'package:flutter/material.dart';
import 'package:hospital/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Hospital System',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
