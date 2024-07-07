import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp/core/constaints/icon_path.dart';
import 'package:testapp/core/constaints/image_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/vertification_code_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
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
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot Password",
                      style: AppTextStyle.s28_w6,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 68),
                  child: Image.asset(ImagePath.forgotPasswordIllustrator),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NameList(Credentials: "Email Address"),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 36, right: 36, bottom: 25),
                        child: Text(
                          "Please write your email to receive a confirmation code to set a new password.",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s13_w4.copyWith(
                              color: Color.fromRGBO(143, 149, 158, 1)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VertificationCodeScreen(),
              ));
        },
        child: const FootPage(
          textfootpage: 'Confirm Mail',
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
