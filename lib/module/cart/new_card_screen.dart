import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/constants/product_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';
import 'package:testapp/widget/switch_widget.dart';
import 'package:testapp/widget/text_field_widget.dart';

/// This Dart class named AddressCreen extends StatelessWidget.
class NewCardScreen extends StatelessWidget {
  const NewCardScreen({super.key});

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
          "Add New Card",
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
              padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 50,
                child: const Row(
                  children: [
                    ListCard(typeCard: ProductPath.typeCard1),
                    const SizedBox(
                      width: 17,
                    ),
                    ListCard(typeCard: ProductPath.typeCard2),
                    SizedBox(
                      width: 17,
                    ),
                    ListCard(typeCard: ProductPath.typeCard3),
                  ],
                ),
              ),
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
                  const SizedBox(
                    width: 15,
                  ),
                  TextFieldWidget(
                      filedSize:
                          Size((MediaQuery.sizeOf(context).width - 55) / 2, 50),
                      filedName: "CVV"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const FootPage(
          textfootpage: 'Add Card',
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final String typeCard;

  const ListCard({super.key, required this.typeCard});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: (MediaQuery.sizeOf(context).width - 74) / 3,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(245, 246, 250, 1)),
      child: Center(
        child: Image.asset(
          typeCard,
          height: 20,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
