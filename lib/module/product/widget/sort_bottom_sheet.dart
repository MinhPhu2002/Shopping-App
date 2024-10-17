import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_color_theme.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/core/values/sort_product_by.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key, this.selectedValue, this.onChange});
  final SortProductBy? selectedValue;
  final void Function(SortProductBy? value)? onChange;
  static const Map<SortProductBy, String> sortOptions = {
    SortProductBy.pricinginAscending: 'Giá từ thấp đến cao',
    SortProductBy.pricinginDescending: 'Giá từ cao đến thấp',
    SortProductBy.titleinAscending: 'Theo tên sản phẩm (A-Z)',
  };
  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  SortProductBy? sortBy;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortBy = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 349,
      decoration: BoxDecoration(
          color: listColors.background,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Sort',
              style: AppTextStyle.s17_w5.copyWith(color: listColors.textMeidum),
            ),
            const SizedBox(height: 32),
            ...SortBottomSheet.sortOptions.entries
                .map(
                  (e) => Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: listColors.colorBox),
                    child: sortSelect(e.value, e.key),
                  ),
                )
                .expand(
                  (element) => [
                    element,
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
            const SizedBox(
              height: 32 - 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 46,
                    width: (MediaQuery.sizeOf(context).width - 70) / 2,
                    decoration: BoxDecoration(
                        color: listColors.colorBox,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: AppTextStyle.s17_w5
                            .copyWith(color: listColors.textSmall),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    widget.onChange?.call(sortBy);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 46,
                    width: (MediaQuery.sizeOf(context).width - 70) / 2,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(151, 117, 250, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Confirms",
                        style: AppTextStyle.s17_w5
                            .copyWith(color: listColors.textBottom),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget sortSelect(String title, SortProductBy value) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return ListTile(
      onTap: () {
        setState(() {
          if (sortBy != value)
            sortBy = value;
          else
            sortBy = null;
        });
      },
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: listColors.textMeidum),
          ),
          const Spacer(),
          SvgPicture.asset(
              sortBy == value ? IconPath.check : IconPath.notcheck),
        ],
      ),
    );
  }
}
