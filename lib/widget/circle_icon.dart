import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CircleIcon extends StatelessWidget {
  final Size sizeIcon;
  final Size sizeCircle;
  final String iconname;
  final Color colorCircle;
  final Color colorBorder;
  CircleIcon(
      {super.key,
      required this.iconname,
      required this.colorCircle,
      required this.sizeIcon,
      required this.sizeCircle,
      required this.colorBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeCircle.width,
      height: sizeCircle.height,
      child: Center(
        child: SvgPicture.asset(
          iconname,
          width: sizeIcon.width,
          height: sizeIcon.height,
          color: Colors.black,
          fit: BoxFit.scaleDown,
        ),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorCircle,
          border: Border.all(
            color: colorBorder,
            width: 1,
          )),
    );
  }
}
