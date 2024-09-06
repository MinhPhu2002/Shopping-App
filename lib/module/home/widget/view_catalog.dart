import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_text_style.dart';

class ViewCatalog extends StatelessWidget {
  final String nameView;

  const ViewCatalog({super.key, required this.nameView});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameView,
            style: AppTextStyle.s17_w5
                .copyWith(color: const Color.fromRGBO(29, 30, 32, 1)),
          ),
          const Text(
            "View All",
            style: TextStyle(
                color: Color.fromRGBO(143, 149, 158, 1), fontSize: 13),
          )
        ],
      ),
    );
  }
}
