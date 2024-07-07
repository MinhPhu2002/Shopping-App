import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/home_screen.dart';
import 'start_screen.dart';

/// Flutter code sample for [InkWell].

void main() => runApp(const InkWellExampleApp());

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
