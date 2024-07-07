import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/address_creen.dart';
import 'package:testapp/order_confirmed_screen.dart';

import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/constaints/image_path.dart';
import 'package:testapp/core/constaints/product_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/payment_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

class CartScreen extends StatelessWidget {
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
        title: Text(
          "Cart",
          style: AppTextStyle.s17_w6.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: const Column(
                children: [
                  CartProduct(
                      PathImage: ImagePath.homeScreenProductImage1Illustrator,
                      Name: "Men's Tie-Dye T-Shirt Nike Sportswear",
                      Cost: "\$99"),
                  CartProduct(
                      PathImage: ProductPath.image8,
                      Name: "Men's Tie-Dye T-Shirt Nike Sportswear",
                      Cost: "\$45"),
                  CartProduct(
                      PathImage: ImagePath.homeScreenProductImage2Illustrator,
                      Name: "Men's Tie-Dye T-Shirt Nike Sportswear",
                      Cost: "\$45"),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressCreen(),
                    ));
              },
              child: const TransactionDetails(
                orderDetails: "Delivery Address",
                contentDetails: "43, Electronics City Phase 1, Electronic City",
                imagePath: IconPath.location,
                bonus: '',
                iconSize: Size(20, 20),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(),
                    ));
              },
              child: const TransactionDetails(
                orderDetails: "Payment Method",
                contentDetails: "Visa Classic",
                imagePath: IconPath.visa,
                bonus: '**** 7690',
                iconSize: Size(30, 30),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "OrderIn",
                      style: AppTextStyle.s17_w5.copyWith(color: Colors.black),
                    ),
                  ),
                  const TotalPayment(nameitem: "Subtotal", costitem: "\$110"),
                  const TotalPayment(nameitem: "Delivery", costitem: "\$10"),
                  const TotalPayment(nameitem: "Total", costitem: "\$120"),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmedScreen(),
              ));
        },
        child: const FootPage(
          textfootpage: 'Checkout',
        ),
      ),
    );
  }
}

class CartProduct extends StatelessWidget {
  final String PathImage;
  final String Name;
  final String Cost;

  const CartProduct(
      {super.key,
      required this.PathImage,
      required this.Name,
      required this.Cost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: 120,
        width: MediaQuery.sizeOf(context).width - 40,
        decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 100,
                  spreadRadius: -15,
                  color: Color.fromRGBO(57, 63, 74, 0.25))
            ],
            color: const Color.fromRGBO(254, 254, 254, 1),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(240, 240, 240, 1)),
              child: Image.asset(
                PathImage,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    maxLines: 2,
                    Name,
                    style: AppTextStyle.s13_w5
                        .copyWith(color: const Color.fromRGBO(29, 30, 32, 1)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    Cost + " (+\$4.00 Tax)",
                    style: AppTextStyle.s11_w5.copyWith(
                      color: const Color.fromRGBO(143, 149, 158, 1),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      CircleIcon(
                        iconname: IconPath.arrowDown,
                        colorCircle: Colors.transparent,
                        sizeIcon: const Size(15, 15),
                        sizeCircle: const Size(25, 25),
                        colorBorder: const Color.fromRGBO(222, 222, 222, 1),
                      ),
                      const SizedBox(width: 20),
                      const Text("1"),
                      const SizedBox(width: 20),
                      CircleIcon(
                        iconname: IconPath.arrowUp,
                        colorCircle: Colors.transparent,
                        sizeIcon: const Size(15, 15),
                        sizeCircle: const Size(25, 25),
                        colorBorder: const Color.fromRGBO(222, 222, 222, 1),
                      ),
                      const Spacer(),
                      CircleIcon(
                        iconname: IconPath.delete,
                        colorCircle: Colors.transparent,
                        sizeIcon: const Size(15, 15),
                        sizeCircle: const Size(25, 25),
                        colorBorder: const Color.fromRGBO(222, 222, 222, 1),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionDetails extends StatelessWidget {
  final String orderDetails;
  final String contentDetails;
  final String imagePath;
  final String bonus;
  final Size iconSize;
  const TransactionDetails(
      {super.key,
      required this.orderDetails,
      required this.contentDetails,
      required this.imagePath,
      required this.bonus,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderDetails,
                style: AppTextStyle.s17_w5.copyWith(color: Colors.black),
              ),
              SvgPicture.asset(IconPath.arrowRight),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 246, 250, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    imagePath,
                    width: iconSize.width,
                    height: iconSize.height,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contentDetails,
                      maxLines: 2,
                      style: AppTextStyle.s15_w4.copyWith(
                          color: const Color.fromRGBO(143, 149, 158, 1)),
                    ),
                    Text(bonus,
                        style: AppTextStyle.s15_w4.copyWith(
                            color: const Color.fromRGBO(143, 149, 158, 1)))
                  ],
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              SvgPicture.asset(IconPath.check),
            ],
          )
        ],
      ),
    );
  }
}

class TotalPayment extends StatelessWidget {
  final String nameitem;
  final String costitem;

  const TotalPayment(
      {super.key, required this.nameitem, required this.costitem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nameitem,
              style: AppTextStyle.s15_w4
                  .copyWith(color: const Color.fromRGBO(143, 149, 158, 1))),
          Text(costitem,
              style: AppTextStyle.s15_w4.copyWith(color: Colors.black))
        ],
      ),
    );
  }
}
