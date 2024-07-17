import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/constants/product_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

/// This Dart class named AddressCreen extends StatelessWidget.
class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Image.asset(
              ProductPath.undrawOrderConfirmedpng,
              width: MediaQuery.sizeOf(context).width - 96,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Order Confirmed!",
            textAlign: TextAlign.center,
            style: AppTextStyle.s28_w6.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              "Your order has been confirmed, we will send you confirmation email shortly.",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppTextStyle.s15_w4
                  .copyWith(color: Color.fromRGBO(143, 149, 158, 1)),
            ),
          ),
          Spacer(),
          GoToOders(),
          SizedBox(
            height: 30,
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.popUntil(context, ModalRoute.withName("Home"));
        },
        child: const FootPage(
          textfootpage: 'Continue Shopping',
        ),
      ),
    );
  }
}

class GoToOders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(245, 245, 245, 1),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Go to Orders",
          style: AppTextStyle.s17_w5
              .copyWith(color: Color.fromRGBO(143, 149, 158, 1)),
        ),
      ),
    );
  }
}
