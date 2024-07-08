import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/cart_screen.dart';
import 'package:testapp/core/constaints/image_path.dart';
import 'package:testapp/core/constaints/product_path.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/review_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/comment.dart';

class DescriptionProductScreen extends StatelessWidget {
  const DescriptionProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            child: CircleIcon(
                iconname: IconPath.back,
                colorCircle: Colors.white,
                sizeIcon: const Size(25, 25),
                sizeCircle: const Size(45, 45),
                colorBorder: Colors.transparent),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
            icon: CircleIcon(
                iconname: IconPath.bag,
                colorCircle: Colors.white,
                sizeIcon: const Size(25, 25),
                sizeCircle: const Size(45, 45),
                colorBorder: Colors.transparent),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                const ColoredBox(color: Color.fromRGBO(245, 246, 250, 1)),
                Padding(
                  padding: const EdgeInsets.only(top: 31),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        ImagePath.homeScreenProductImage1Illustrator,
                        width: 310,
                        fit: BoxFit.fill,
                      ),
                      SvgPicture.asset(IconPath.logo),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Expanded(
                          child: Text(
                            "Men's Printed Pullover Hoodie",
                            style: AppTextStyle.s13_w4.copyWith(
                                color: const Color.fromRGBO(143, 149, 158, 1)),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Price",
                          style: AppTextStyle.s13_w4.copyWith(
                              color: const Color.fromRGBO(143, 149, 158, 1)),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nike Club Fleece",
                          style: AppTextStyle.s22_w6.copyWith(
                              color: const Color.fromRGBO(29, 30, 32, 1)),
                        ),
                        Text(
                          "\$99",
                          style: AppTextStyle.s22_w6.copyWith(
                              color: const Color.fromRGBO(29, 30, 32, 1)),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ProductInformation(
                              PathProductInformation: ProductPath.product11),
                          ProductInformation(
                              PathProductInformation: ProductPath.product12),
                          ProductInformation(
                              PathProductInformation: ProductPath.product13),
                          ProductInformation(
                              PathProductInformation: ProductPath.product14),
                          ProductInformation(
                              PathProductInformation: ProductPath.product12),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Size",
                          style: AppTextStyle.s17_w6.copyWith(
                              color: const Color.fromRGBO(29, 30, 32, 1)),
                        ),
                        Text(
                          "Size Guide ",
                          style: AppTextStyle.s15_w4.copyWith(
                              color: const Color.fromRGBO(143, 149, 158, 1)),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    // ignore: prefer_const_constructors
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: const Row(
                        children: [
                          ProductSize(size: "S"),
                          ProductSize(size: "M"),
                          ProductSize(size: "L"),
                          ProductSize(size: "Xl"),
                          ProductSize(size: "2XL"),
                          ProductSize(size: "3XL"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Description",
                      style: AppTextStyle.s17_w6,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                              "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with ",
                          style: AppTextStyle.s15_w4.copyWith(
                            color: const Color.fromRGBO(143, 149, 158, 1),
                          ),
                        ),
                        TextSpan(
                          text: "Read More..",
                          style:
                              AppTextStyle.s15_w6.copyWith(color: Colors.black),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Review",
                          style: AppTextStyle.s17_w6.copyWith(
                              color: const Color.fromRGBO(29, 30, 32, 1)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewScreen(),
                                  settings: const RouteSettings(name: "review"),
                                ));
                          },
                          child: Text("View All",
                              style: AppTextStyle.s13_w4.copyWith(
                                color: const Color.fromRGBO(143, 149, 158, 1),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Comment(
                avatar: ProductPath.avatar2,
                name: "Guy Hawkins",
                time: '13 Sep, 2020',
                ratingScore: 4.8,
                comment:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
          ],
        ),
      ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  final String PathProductInformation;

  const ProductInformation({super.key, required this.PathProductInformation});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Container(
        width: (MediaQuery.sizeOf(context).width - 67) / 4,
        height: (MediaQuery.sizeOf(context).width - 67) / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(PathProductInformation), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class ProductSize extends StatelessWidget {
  final String size;

  const ProductSize({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Container(
        width: (MediaQuery.sizeOf(context).width - 76) / 5,
        height: (MediaQuery.sizeOf(context).width - 76) / 5,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(245, 246, 250, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            size,
            style: AppTextStyle.s17_w6.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
