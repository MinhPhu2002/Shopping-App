import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/theme/app_color_theme.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/repo/login_repo.dart';
import 'package:testapp/widget/bottom_action_button.dart';
import 'package:testapp/widget/circle_icon.dart';

import '../../../core/constants/icon_path.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({
    super.key,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return Scaffold(
      backgroundColor: listColors.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5, left: 20),
          child: InkWell(
            child: CircleIcon(
                iconname: IconPath.back,
                colorCircle: listColors.colorBox,
                sizeIcon: const Size(25, 25),
                sizeCircle: const Size(45, 45),
                colorBorder: Colors.transparent),
            onTap: () {},
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's Get Started",
                      style: AppTextStyle.s28_w6
                          .copyWith(color: listColors.textMeidum),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: const Alignment(0, 185 / 559),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const InkWellExample(
                          nameIcon: FontAwesomeIcons.facebook,
                          backGroundColor: Color.fromRGBO(66, 103, 178, 1),
                          label: 'Facebook',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const InkWellExample(
                          backGroundColor: Color.fromRGBO(29, 161, 242, 1),
                          label: 'Twitter',
                          nameIcon: FontAwesomeIcons.twitter,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            var user =
                                await LoginRepository().signInWithGoogle();
                            if (user == true) {
                              print('Signed in with Google ');
                              context.pushNamed('home');
                            }
                          },
                          child: const InkWellExample(
                            nameIcon: FontAwesomeIcons.google,
                            backGroundColor: Color.fromRGBO(234, 67, 53, 1),
                            label: 'Google',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => context.pushNamed('login'),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Already have an account? ",
                  style: AppTextStyle.s15_w4
                      .copyWith(color: const Color.fromRGBO(143, 149, 158, 1))),
              TextSpan(
                text: "Signin",
                style:
                    AppTextStyle.s15_w5.copyWith(color: listColors.textMeidum),
              )
            ])),
          ),
          const SizedBox(
            height: 25,
          ),
          BottomActionButton(
              textfootpage: 'Create an Account',
              onTap: () {
                // context.goNamed('signup');
                context.pushNamed('signup');
              })
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
    return Ink(
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
    );
  }
}
