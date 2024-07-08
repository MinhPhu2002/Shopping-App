import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/constaints/product_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/cart/new_card_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';
import 'package:testapp/widget/switch_widget.dart';
import 'package:testapp/widget/text_field_widget.dart';

/// This Dart class named AddressCreen extends StatelessWidget.
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
        title: Text(
          "Payment",
          style: AppTextStyle.s17_w6.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, top: 25),
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 185,
                child: Row(
                  children: [
                    Image.asset(
                      ProductPath.card1,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset(
                      ProductPath.card1,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewCardScreen()));
                  },
                  child: AddNewCard()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: TextFieldWidget(
                  filedSize: Size(MediaQuery.sizeOf(context).width, 50),
                  filedName: "Card Owner"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
              child: TextFieldWidget(
                  filedSize: Size(MediaQuery.sizeOf(context).width, 50),
                  filedName: "Card Number"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  TextFieldWidget(
                      filedSize:
                          Size((MediaQuery.sizeOf(context).width - 55) / 2, 50),
                      filedName: "EXP"),
                  SizedBox(
                    width: 15,
                  ),
                  TextFieldWidget(
                      filedSize:
                          Size((MediaQuery.sizeOf(context).width - 55) / 2, 50),
                      filedName: "CVV"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwitchWidget(nameSwitch: "Save card info"),
            )
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const FootPage(
          textfootpage: 'Save Card',
        ),
      ),
    );
  }
}

class AddNewCard extends StatelessWidget {
  const AddNewCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width - 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(246, 242, 255, 1),
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(151, 117, 250, 1),
          )),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconPath.plus,
              color: Color.fromRGBO(151, 117, 250, 1),
            ),
            SizedBox(width: 5),
            Text(
              "Add new card",
              style: AppTextStyle.s17_w5
                  .copyWith(color: Color.fromRGBO(151, 117, 250, 1)),
            )
          ],
        ),
      ),
    );
  }
}
