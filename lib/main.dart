import 'package:flutter/material.dart';
import 'package:testapp/core/api/firebase_api.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/data/services/auth_service.dart';
import 'module/auth/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Flutter code sample for [InkWell].

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const InkWellExampleApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
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
