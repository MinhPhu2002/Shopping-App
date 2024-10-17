import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_color_theme.dart';

class Credential extends StatelessWidget {
  const Credential(
      {super.key,
      required this.credentials,
      required this.obscureText,
      required this.data});
  final String credentials;
  final bool obscureText;
  final TextEditingController data;
  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          TextField(
            cursorColor: listColors.textMeidum,
            style: TextStyle(color: listColors.textMeidum),
            controller: data,
            decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: credentials,
                focusColor: listColors.textMeidum,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: listColors.textMeidum)),
                labelStyle: TextStyle(color: listColors.textMeidum),
                hintStyle: TextStyle(color: listColors.textMeidum)),
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }
}
