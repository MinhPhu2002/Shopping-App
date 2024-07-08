import 'package:flutter/material.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';
import 'package:testapp/widget/text_field_widget.dart';

class AddReviewScreen extends StatelessWidget {
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
          "Add Review",
          style: AppTextStyle.s17_w6.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFieldWidget(
                filedSize: Size(MediaQuery.sizeOf(context).width - 40, 50),
                filedName: "Name"),
            SizedBox(
              height: 30,
            ),
            TextFieldWidget(
                filedSize: Size(MediaQuery.sizeOf(context).width - 40, 213),
                filedName: "How was your experience ?"),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const FootPage(
          textfootpage: 'Submit Review',
        ),
      ),
    );
  }
}
