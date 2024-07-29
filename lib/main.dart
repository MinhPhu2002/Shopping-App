import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/data/services/auth_service.dart';
import 'module/auth/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Flutter code sample for [InkWell].

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.initialize();
  runApp(const InkWellExampleApp());
}

class InkWellExampleApp extends StatelessWidget {
  const InkWellExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: AppTextStyle.fontFamily,
          textTheme: TextTheme(
            titleMedium: TextStyle(fontFamily: AppTextStyle.fontFamily),
            titleSmall: TextStyle(fontFamily: AppTextStyle.fontFamily),
            titleLarge: TextStyle(fontFamily: AppTextStyle.fontFamily),
          )),
      home: StartScreen(),
      // home: HomeScreen(),
    );
  }
}
