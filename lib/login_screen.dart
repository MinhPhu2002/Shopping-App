import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';

import 'package:testapp/recomment_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
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
      body: Column(
        children: [
          Column(
            children: [
              Text(
                "Welcome",
                style: AppTextStyle.s28_w6,
                textAlign: TextAlign.center,
              ),
              Text(
                "Please enter your data to continue",
                style: AppTextStyle.s15_w4
                    .copyWith(color: Color.fromRGBO(143, 149, 158, 1)),
                textAlign: TextAlign.end,
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  const NameList(Credentials: "Username"),
                  SizedBox(
                    height: 20 * MediaQuery.sizeOf(context).height / 812,
                  ),
                  const NameList(Credentials: "Password"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30 * MediaQuery.sizeOf(context).height / 812,
                            right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ));
                          },
                          child: Text(
                            "Forgot password?",
                            style: AppTextStyle.s15_w4.copyWith(
                                color: Color.fromRGBO(234, 67, 53, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 40 * MediaQuery.sizeOf(context).height / 812,
                        left: 20,
                        right: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Remember me",
                          style: AppTextStyle.s13_w5,
                        ),
                        SwitchState(),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                    child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                              text:
                                  "By connecting your account confirm that you agree with our ",
                              style: AppTextStyle.s13_w4.copyWith(
                                  color: Color.fromRGBO(143, 149, 158, 1))),
                          TextSpan(
                              text: "Term and Condition",
                              style: AppTextStyle.s13_w5)
                        ])),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecommentScreen(),
            ),
          );
        },
        child: const FootPage(
          textfootpage: 'Login',
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

class NameList extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const NameList({super.key, required this.Credentials});
  // ignore: non_constant_identifier_names
  final String Credentials;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: Credentials,
            ),
          ),
        ],
      ),
    );
  }
}
