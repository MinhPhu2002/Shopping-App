import 'package:flutter/material.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/core/theme/app_color_theme.dart';

class ViewCatalog extends StatelessWidget {
  final String nameView;

  const ViewCatalog({super.key, required this.nameView});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final AppColorTheme listColors =
        Theme.of(context).extension<AppColorTheme>()!;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameView,
            style: AppTextStyle.s17_w5.copyWith(color: listColors.textMeidum),
          ),
          Text(
            "View All",
            style: TextStyle(color: listColors.textSmall, fontSize: 13),
          )
        ],
      ),
    );
  }
}
