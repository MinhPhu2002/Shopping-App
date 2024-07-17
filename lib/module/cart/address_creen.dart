import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';
import 'package:testapp/widget/switch_widget.dart';
import 'package:testapp/widget/text_field_widget.dart';

/// This Dart class named AddressCreen extends StatelessWidget.
class AddressCreen extends StatelessWidget {
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
          "Address",
          style: AppTextStyle.s17_w6.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFieldWidget(
                filedSize: Size(MediaQuery.sizeOf(context).width - 40, 50),
                filedName: "Name"),
            const SizedBox(height: 15),
            Row(
              children: [
                TextFieldWidget(
                    filedSize:
                        Size((MediaQuery.sizeOf(context).width - 55) / 2, 50),
                    filedName: "Country"),
                const SizedBox(
                  width: 15,
                ),
                TextFieldWidget(
                    filedSize:
                        Size((MediaQuery.sizeOf(context).width - 55) / 2, 50),
                    filedName: "City"),
              ],
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
                filedSize: Size(MediaQuery.sizeOf(context).width - 40, 50),
                filedName: "Phone Number"),
            const SizedBox(height: 15),
            TextFieldWidget(
                filedSize: Size(MediaQuery.sizeOf(context).width - 40, 50),
                filedName: "Address"),
            const SizedBox(
              height: 24,
            ),
            const SwitchWidget(nameSwitch: "Save as primary address")
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const FootPage(
          textfootpage: 'Save Address',
        ),
      ),
    );
  }
}
