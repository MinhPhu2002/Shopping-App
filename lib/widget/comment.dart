import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/widget/rating.dart';

class Comment extends StatelessWidget {
  final String avatar;
  final String name;
  final String time;
  final double ratingScore;
  final String comment;

  const Comment(
      {super.key,
      required this.avatar,
      required this.name,
      required this.time,
      required this.ratingScore,
      required this.comment});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.sizeOf(context).width - 40,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      avatar,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyle.s15_w5,
                    ),
                    const SizedBox(width: 7),
                    Row(
                      children: [
                        SvgPicture.asset(IconPath.clock),
                        const SizedBox(width: 5),
                        Text(time,
                            style: AppTextStyle.s11_w5.copyWith(
                                color: const Color.fromRGBO(143, 149, 158, 1)))
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ratingScore.toString() + " rating",
                      style: AppTextStyle.s15_w5,
                    ),
                    rating(),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              comment,
              style: AppTextStyle.s15_w4
                  .copyWith(color: const Color.fromRGBO(143, 149, 158, 1)),
            )
          ],
        ),
      ),
    );
  }
}
