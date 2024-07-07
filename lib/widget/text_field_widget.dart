import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/theme/app_text_style.dart';

class TextFieldWidget extends StatelessWidget {
  final Size filedSize;
  final String filedName;

  const TextFieldWidget(
      {super.key, required this.filedSize, required this.filedName});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filedName,
          style: AppTextStyle.s17_w5
              .copyWith(color: Color.fromRGBO(29, 30, 32, 1)),
        ),
        SizedBox(
          height: 10,
        ),
        Ink(
          width: filedSize.width,
          height: filedSize.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(245, 246, 250, 1)),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Type Here",
              fillColor: Color.fromRGBO(245, 246, 250, 1),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintStyle: const TextStyle(
                  fontSize: 17, color: Color.fromRGBO(143, 149, 158, 1)),
            ),
          ),
        ),
      ],
    );
  }
}
