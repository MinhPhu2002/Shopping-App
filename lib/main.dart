import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/data/services/auth_service.dart';
import 'package:testapp/module/service/notification_service.dart';
import 'module/auth/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationService.instance.initialize();
  runApp(const InkWellExampleApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
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
