import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/login_cubit.dart';
import 'package:testapp/module/auth/bloc/login_state.dart';

import 'package:testapp/module/auth/recomment_screen.dart';
import 'package:testapp/module/detail/description_product_screen.dart';
import 'package:testapp/module/home/bloc/brands/brands_cubit.dart';
import 'package:testapp/module/home/bloc/products/products_cubit.dart';
import 'package:testapp/module/home/bloc/user/user_cubit.dart';
import 'package:testapp/module/home/bloc/user/user_state.dart';
import 'package:testapp/module/home/home_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';
import 'package:testapp/widget/switch_widget.dart';

import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  Crendentials(
                    credentials: "Username",
                    obscureText: false,
                    data: _userNameController,
                  ),
                  SizedBox(
                    height: 20 * MediaQuery.sizeOf(context).height / 812,
                  ),
                  Crendentials(
                    credentials: "Password",
                    obscureText: true,
                    data: _passwordController,
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoadingInProgress) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is LoginSuccess) {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              settings: RouteSettings(name: 'Home'),
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => UserCubit(),
                                  ),
                                  BlocProvider(
                                    create: (context) => ProductsCubit(),
                                  ),
                                  BlocProvider(
                                    create: (context) => BrandsCubit(),
                                  ),
                                ],
                                child: HomeScreen(),
                              ),
                            ), (route) {
                          return false;
                        });
                      } else if (state is LoginLoadingError) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                              child: Container(
                                  color: Colors.yellow,
                                  child: Text(state.errorMessage))),
                        );
                      }
                    },
                    child: Row(
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
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 40 * MediaQuery.sizeOf(context).height / 812,
                          left: 20,
                          right: 20),
                      child: SwitchWidget(nameSwitch: "Remember me")),
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
          context.read<LoginCubit>().login(
                _userNameController.text,
                _passwordController.text,
              );
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => RecommentScreen(),
          //     ));
        },
        child: const FootPage(
          textfootpage: 'Login',
        ),
      ),
    ));
  }
}

class Crendentials extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Crendentials(
      {super.key,
      required this.credentials,
      required this.obscureText,
      required this.data});
  // ignore: non_constant_identifier_names
  final String credentials;
  final bool obscureText;
  final TextEditingController data;
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
            controller: data,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: credentials,
            ),
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }
}
