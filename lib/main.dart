import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/common/app_setting.dart';
import 'package:testapp/common/repo/app_setting_repo.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/core/theme/app_color_theme.dart';
import 'package:testapp/data/services/auth_service.dart';
import 'package:testapp/module/service/notification_service.dart';
import 'package:testapp/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppSetting.ensureInitialized();
  AuthService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationService.instance.initialize();
  runApp(InkWellExampleApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class InkWellExampleApp extends StatefulWidget {
  InkWellExampleApp({super.key});

  @override
  State<InkWellExampleApp> createState() => _InkWellExampleAppState();
}

class _InkWellExampleAppState extends State<InkWellExampleApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void initialization() async {}
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppSetting.isdarkthemeNotifier,
      builder: (context, isdarktheme, child) {
        return MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            fontFamily: AppTextStyle.fontFamily,
            extensions: <ThemeExtension<dynamic>>[
              AppColorTheme(
                  textMeidum: Colors.black,
                  textBottom: Colors.white,
                  colorBox: const Color.fromRGBO(245, 246, 250, 1),
                  textSmall: Color.fromRGBO(143, 149, 158, 1),
                  background: Color.fromRGBO(254, 254, 254, 1))
            ],
            textTheme: TextTheme(
              titleMedium: TextStyle(fontFamily: AppTextStyle.fontFamily),
              titleSmall: TextStyle(fontFamily: AppTextStyle.fontFamily),
              titleLarge: TextStyle(fontFamily: AppTextStyle.fontFamily),
            ),
            primaryColor: Colors.white,
            primaryTextTheme:
                TextTheme(bodyLarge: TextStyle(color: Colors.black)),
            cardColor: Color.fromRGBO(245, 246, 250, 1),
            canvasColor: Color.fromRGBO(245, 246, 250, 1),
          ),
          darkTheme: ThemeData(
              fontFamily: AppTextStyle.fontFamily,
              extensions: <ThemeExtension<dynamic>>[
                AppColorTheme(
                    textMeidum: Colors.white,
                    textBottom: Colors.black,
                    colorBox: const Color.fromRGBO(41, 54, 61, 1),
                    textSmall: Color.fromRGBO(143, 149, 158, 1),
                    background: Color.fromRGBO(27, 38, 44, 1))
              ],
              textTheme: TextTheme(
                titleMedium: TextStyle(fontFamily: AppTextStyle.fontFamily),
                titleSmall: TextStyle(fontFamily: AppTextStyle.fontFamily),
                titleLarge: TextStyle(fontFamily: AppTextStyle.fontFamily),
              ),
              primaryColor: Color.fromRGBO(27, 38, 44, 1),
              primaryTextTheme:
                  TextTheme(bodyLarge: TextStyle(color: Colors.white)),
              cardColor: Color.fromRGBO(34, 46, 52, 1),
              canvasColor: Color.fromRGBO(245, 246, 250, 1)),
          themeMode: isdarktheme ? ThemeMode.dark : ThemeMode.light,
          // home: HomeScreen(),
        );
      },
    );
  }
}
