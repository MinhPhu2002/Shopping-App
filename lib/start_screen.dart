import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/signup_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

import 'core/constaints/icon_path.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double scaleWidth = MediaQuery.sizeOf(context).width / 375;
    final double scaleHeight = MediaQuery.sizeOf(context).height / 812;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5, left: 20),
          child: InkWell(
            child: CircleIcon(
                iconname: IconPath.back,
                colorCircle: Color.fromRGBO(245, 246, 250, 1),
                sizeIcon: Size(25, 25),
                sizeCircle: Size(45, 45),
                colorBorder: Colors.transparent),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: const Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's Get Started",
                          style: AppTextStyle.s28_w6,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment(0, 185 / 559),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWellExample(
                              nameIcon: FontAwesomeIcons.facebook,
                              backGroundColor: Color.fromRGBO(66, 103, 178, 1),
                              label: 'Facebook',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWellExample(
                              backGroundColor: Color.fromRGBO(29, 161, 242, 1),
                              label: 'Twitter',
                              nameIcon: FontAwesomeIcons.twitter,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWellExample(
                              nameIcon: FontAwesomeIcons.google,
                              backGroundColor: Color.fromRGBO(234, 67, 53, 1),
                              label: 'Google',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]))),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Already have an account? ",
                style: AppTextStyle.s15_w4
                    .copyWith(color: const Color.fromRGBO(143, 149, 158, 1))),
            const TextSpan(
              text: "Signin",
              style: AppTextStyle.s15_w5,
            )
          ])),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ));
            },
            child: const FootPage(
              textfootpage: 'Create an Account',
            ),
          ),
        ],
      ),
    );
  }
}

/// This class represents an example of using the InkWell widget in a Flutter application.
class InkWellExample extends StatelessWidget {
  const InkWellExample(
      {super.key,
      required this.backGroundColor,
      required this.label,
      required this.nameIcon});
  final IconData nameIcon;
  final Color backGroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              nameIcon,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: AppTextStyle.s17_w6.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
