import 'package:flutter/material.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_color_theme.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/widget/circle_icon.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.onchange,
    this.priceFrom,
    this.priceTo,
  });
  final String? priceFrom;
  final String? priceTo;

  final void Function(String? priceFrom, String? priceTo) onchange;
  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  TextEditingController? priceFromController;
  TextEditingController? priceToController;

  @override
  void initState() {
    priceFromController = TextEditingController(text: widget.priceFrom);
    priceToController = TextEditingController(text: widget.priceTo);
    priceFromController?.addListener(_updatePriceRange);
    priceToController?.addListener(_updatePriceRange);
    super.initState();
  }

  void _updatePriceRange() {
    setState(() {}); // Trigger UI update
  }

  @override
  void dispose() {
    priceFromController?.dispose();
    priceToController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 325,
      decoration: BoxDecoration(
          color: listColors.background,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: AppTextStyle.s17_w5
                      .copyWith(color: listColors.textMeidum),
                ),
                InkWell(
                  onTap: () {
                    priceFromController?.clear();
                    priceToController?.clear();
                    widget.onchange.call(
                        priceFromController?.text, priceToController?.text);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 61,
                    height: 37,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(0, 255, 234, 1)),
                    child: Center(
                      child: Text(
                        'Reset',
                        style: AppTextStyle.s15_w5
                            .copyWith(color: listColors.textBottom),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Price Range',
              style: AppTextStyle.s17_w5.copyWith(color: listColors.textMeidum),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: listColors.colorBox),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: priceFromController,
                    decoration: InputDecoration(
                      hintText: "From",
                      fillColor: listColors.textSmall,
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintStyle:
                          TextStyle(fontSize: 17, color: listColors.textSmall),
                    ),
                  ),
                ),
                Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: listColors.colorBox),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: priceToController,
                    decoration: const InputDecoration(
                      hintText: "To",
                      fillColor: Color.fromRGBO(245, 246, 250, 1),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintStyle: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(143, 149, 158, 1)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            if (priceFromController?.text.isNotEmpty == true ||
                priceToController?.text.isNotEmpty == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'From ${priceFromController?.text}\$ to ${priceToController?.text}\$',
                    style: AppTextStyle.s11_w5
                        .copyWith(color: listColors.textSmall),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      priceFromController?.clear();
                      priceToController?.clear();
                    },
                    child: CircleIcon(
                      iconname: IconPath.delete,
                      colorCircle: listColors.colorBox,
                      sizeIcon: const Size(15, 15),
                      sizeCircle: const Size(25, 25),
                      colorBorder: listColors.textSmall,
                    ),
                  ),
                ],
              ),
            const Spacer(),
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
                    widget.onchange.call(
                        priceFromController?.text, priceToController?.text);
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
            ),
          ],
        ),
      ),
    );
  }
}
