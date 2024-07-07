import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/add_review_screen.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/constaints/product_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            child: CircleIcon(
              iconname: IconPath.back,
              colorCircle: const Color.fromRGBO(245, 246, 250, 1),
              sizeIcon: const Size(25, 25),
              sizeCircle: const Size(45, 45),
              colorBorder: Colors.transparent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Reviews",
          style: AppTextStyle.s17_w6.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              NumberReviews(),
              const SizedBox(height: 10),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Comment(
                          avatar: ProductPath.avatar1,
                          name: "Jenny Wilson",
                          time: '13 Sep, 2020',
                          ratingScore: 4.8,
                          comment:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
                      Comment(
                          avatar: ProductPath.avatar2,
                          name: "Ronald Richards",
                          time: '13 Sep, 2020',
                          ratingScore: 4.8,
                          comment:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
                      Comment(
                          avatar: ProductPath.avatar3,
                          name: "Guy Hawkins",
                          time: '13 Sep, 2020',
                          ratingScore: 4.8,
                          comment:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
                      Comment(
                          avatar: ProductPath.avatar1,
                          name: "Jenny Wilson",
                          time: '13 Sep, 2020',
                          ratingScore: 4.8,
                          comment:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
                      Comment(
                          avatar: ProductPath.avatar3,
                          name: "Guy Hawkins",
                          time: '13 Sep, 2020',
                          ratingScore: 4.8,
                          comment:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
                      Comment(
                          avatar: ProductPath.avatar3,
                          name: "Guy Hawkins",
                          time: '13 Sep, 2020',
                          ratingScore: 4.8,
                          comment:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Column(
          children: [
            const Text("245 Reviews", style: AppTextStyle.s15_w5),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text("4.8", style: AppTextStyle.s13_w4),
                const SizedBox(width: 1),
                rating(),
              ],
            )
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddReviewScreen(),
                ));
          },
          child: Image.asset(
            ProductPath.addReview,
            width: 114,
            height: 35,
          ),
        )
      ],
    );
  }
}

class rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 70,
      height: 15,
      child: RatingBar(
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
        onRatingChanged: (value) => debugPrint('$value'),
        initialRating: 4.2,
        maxRating: 5,
        size: 13,
        filledColor: const Color.fromRGBO(255, 152, 31, 1),
      ),
    );
  }
}

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
