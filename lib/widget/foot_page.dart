import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp/core/theme/app_color_theme.dart';

/// This class represents a Flutter widget for a foot page in a mobile application.
class FootPage extends StatelessWidget {
  final String textfootpage;

  const FootPage({super.key, required this.textfootpage});

  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return Ink(
      width: MediaQuery.sizeOf(context).width,
      color: const Color.fromRGBO(151, 117, 250, 1),
      height: 75 * MediaQuery.sizeOf(context).height / 812,
      child: Center(
        child: Text(
          textfootpage,
          style: TextStyle(color: listColors.textBottom, fontSize: 17),
        ),
      ),
    );
  }
}
