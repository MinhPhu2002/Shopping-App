import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/constants/icon_path.dart';

class VoiceIcon extends StatelessWidget {
  const VoiceIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(151, 117, 250, 1),
            borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          icon: SvgPicture.asset(
            IconPath.voice,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
