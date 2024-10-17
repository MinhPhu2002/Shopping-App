import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_color_theme.dart';

class BottomActionButton extends StatelessWidget {
  final String textfootpage;
  final void Function() onTap;
  const BottomActionButton(
      {super.key, required this.textfootpage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: MediaQuery.sizeOf(context).width,
        color: const Color.fromRGBO(151, 117, 250, 1),
        height: 75 * MediaQuery.sizeOf(context).height / 812,
        child: Center(
          child: Text(
            textfootpage,
            style: TextStyle(color: listColors.textBottom, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
