import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/cart_screen.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/constaints/image_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/description_product_screen.dart';
import 'package:testapp/utilities/ui/mediaquery_extention.dart';
import 'package:testapp/widget/circle_icon.dart';

class BrandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        centerTitle: true,
        title: Container(
          width: 68,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(245, 246, 250, 1)),
          child: Center(
            child: Image.asset(
              ImagePath.homeScreenIconNikeIllustrator,
              width: 48,
              height: 25,
            ),
          ),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              icon: CircleIcon(
                  iconname: IconPath.bag,
                  colorCircle: Color.fromRGBO(245, 246, 250, 1),
                  sizeIcon: Size(25, 25),
                  sizeCircle: Size(45, 45),
                  colorBorder: Colors.transparent)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "365 Items",
                          style: AppTextStyle.s17_w5,
                        ),
                        Text(
                          "Available in stock",
                          style: AppTextStyle.s15_w4.copyWith(
                              color: Color.fromRGBO(143, 149, 158, 1)),
                        )
                      ],
                    ),
                    Container(
                      width: 71,
                      height: 37,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(245, 246, 250, 1)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconPath.sort),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Sort",
                              style: AppTextStyle.s15_w5,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: 160 / 257,
                  children: const [
                    ListItem(
                      productImage:
                          ImagePath.homeScreenProductImage1Illustrator,
                      productName: "Nike Sportswear Club Fleece",
                      productCost: "\$99",
                    ),
                    ListItem(
                      productImage:
                          ImagePath.homeScreenProductImage2Illustrator,
                      productName: "Trail Running Jacket Nike Windrunner",
                      productCost: "\$80",
                    ),
                    ListItem(
                      productImage:
                          ImagePath.homeScreenProductImage3Illustrator,
                      productName: "Nike Sportswear Club Fleece",
                      productCost: "\$100",
                    ),
                    ListItem(
                      productImage:
                          ImagePath.homeScreenProductImage4Illustrator,
                      productName: "Nike Sportswear Club Fleece",
                      productCost: "\$100",
                    ),
                    ListItem(
                      productImage:
                          ImagePath.homeScreenProductImage1Illustrator,
                      productName: "Nike Sportswear Club Fleece",
                      productCost: "\$99",
                    ),
                    ListItem(
                      productImage:
                          ImagePath.homeScreenProductImage2Illustrator,
                      productName: "Trail Running Jacket Nike Windrunner",
                      productCost: "\$80",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productCost;

  const ListItem(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productCost});
  @override
  Widget build(BuildContext context) {
    final imageSize =
        context.getResponSizeBasOnWidth(designWidth: 160, designHeight: 203);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionProductScreen(),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: imageSize.width,
                height: imageSize.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(productImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 6,
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      ImagePath.homeScreenHeartIconIllustrator,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            overflow: TextOverflow.ellipsis,
            productName,
            style: AppTextStyle.s11_w5,
          ),
          const SizedBox(height: 5),
          Text(
            productCost,
            style: AppTextStyle.s13_w6
                .copyWith(color: const Color.fromRGBO(29, 30, 32, 1)),
          )
        ],
      ),
    );
  }
}
