import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/login_cubit.dart';
import 'package:testapp/module/auth/screen/login_screen.dart';
import 'package:testapp/widget/bottom_action_button.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/switch_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double scaleHeight = MediaQuery.sizeOf(context).height / 812;
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkResponse(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(50),
            highlightShape: BoxShape.rectangle,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: CircleIcon(
                  iconname: IconPath.back,
                  colorCircle: Color.fromRGBO(245, 246, 250, 1),
                  sizeIcon: Size(25, 25),
                  sizeCircle: Size(45, 45),
                  colorBorder: Colors.transparent),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: AppTextStyle.s28_w6,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 152 * scaleHeight),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NameList(Credentials: "Username"),
                        const SizedBox(
                          height: 20,
                        ),
                        NameList(Credentials: "Password"),
                        SizedBox(
                          height: 20,
                        ),
                        NameList(Credentials: "Email Address"),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: SwitchWidget(nameSwitch: "Remember me"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomActionButton(
            textfootpage: "Sign Up",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => LoginCubit(),
                      child: LoginScreen(),
                    ),
                    settings: RouteSettings(name: "loginScreen"),
                  ));
            }));
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
