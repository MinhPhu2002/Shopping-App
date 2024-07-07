import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp/core/constaints/image_path.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/new_password_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

import 'core/constaints/icon_path.dart';

class VertificationCodeScreen extends StatelessWidget {
  const VertificationCodeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Verification Code",
                    style: AppTextStyle.s28_w6,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 68),
                child: Image.asset(
                  ImagePath.forgotPasswordIllustrator,
                  width: 255,
                  height: 166,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 5, right: 5),
                child: OtpInput(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 36, right: 36, bottom: 25),
                        child: Text.rich(TextSpan(children: [
                          const TextSpan(
                            text: "00:20",
                            style: AppTextStyle.s13_w5,
                          ),
                          TextSpan(
                              text: " resend confirmation code.",
                              style: AppTextStyle.s13_w4.copyWith(
                                  color:
                                      const Color.fromRGBO(143, 149, 158, 1))),
                        ])))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPasswordScreen(),
              ));
        },
        child: const FootPage(
          textfootpage: 'Confirm Code',
        ),
      ),
    ));
  }
}

class SwitchState extends StatelessWidget {
  const SwitchState({super.key});

  // const SwitchState({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool light = true;
    return Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          value: light,
          activeColor: const Color.fromRGBO(52, 199, 89, 1),
          onChanged: (bool value) {
            light = value;
          },
        ));
  }
}

class OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement createState
    return PinCodeTextField(
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 98,
        fieldWidth: 77 * MediaQuery.sizeOf(context).width / 375,
        activeFillColor: const Color.fromRGBO(231, 232, 234, 1),
        activeColor: const Color.fromRGBO(231, 232, 234, 1),
        inactiveColor: const Color.fromRGBO(231, 232, 234, 1),
      ),
      length: 4,
      appContext: context,
    );
  }
}
