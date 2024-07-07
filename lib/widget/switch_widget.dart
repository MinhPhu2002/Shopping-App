import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_text_style.dart';

class SwitchWidget extends StatelessWidget {
  final String nameSwitch;

  const SwitchWidget({super.key, required this.nameSwitch});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool light = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nameSwitch,
          style: AppTextStyle.s15_w5,
        ),
        Ink(
          width: 45,
          height: 25,
          child: CupertinoSwitch(
            value: light,
            activeColor: const Color.fromRGBO(52, 199, 89, 1),
            onChanged: (bool value) {
              light = value;
            },
          ),
        )
      ],
    );
  }
}
