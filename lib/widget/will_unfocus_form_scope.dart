import 'package:flutter/material.dart';

class WillUnfocusFormScope extends StatelessWidget {
  const WillUnfocusFormScope({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
