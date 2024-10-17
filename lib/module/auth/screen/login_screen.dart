import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/app_authentication.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_color_theme.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/login_cubit.dart';
import 'package:testapp/module/auth/bloc/login_state.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/credential.dart';
import 'package:testapp/widget/foot_page.dart';
import 'package:testapp/widget/switch_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements AppAuthenticationBindingObserver {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    AppAuthenticationBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    AppAuthenticationBinding.instance?.removeObserver(this);
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors = AppColorTheme.of(context);
    return (Scaffold(
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
                style:
                    AppTextStyle.s28_w6.copyWith(color: listColors.textMeidum),
                textAlign: TextAlign.center,
              ),
              Text(
                "Please enter your data to continue",
                style:
                    AppTextStyle.s15_w4.copyWith(color: listColors.textSmall),
                textAlign: TextAlign.end,
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Credential(
                    credentials: "Username",
                    obscureText: false,
                    data: _userNameController,
                  ),
                  SizedBox(
                    height: 20 * MediaQuery.sizeOf(context).height / 812,
                  ),
                  Credential(
                    credentials: "Password",
                    obscureText: true,
                    data: _passwordController,
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoadingInProgress) {
                        showDialog(
                          context: context,
                          builder: (context) => const Center(
                              child: const CircularProgressIndicator()),
                        );
                      } else if (state is LoginSuccess) {
                        context.pop();
                        context.pushNamed('vertification', extra: {
                          'username': _userNameController.text,
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
                              context.pushNamed('forgotPassword');
                            },
                            child: Text(
                              "Forgot password?",
                              style: AppTextStyle.s15_w4.copyWith(
                                  color: const Color.fromRGBO(234, 67, 53, 1)),
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
                      child: const SwitchWidget(nameSwitch: "Remember me")),
                  const Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                    child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                              text:
                                  "By connecting your account confirm that you agree with our ",
                              style: AppTextStyle.s13_w4.copyWith(
                                  color:
                                      const Color.fromRGBO(143, 149, 158, 1))),
                          TextSpan(
                              text: "Term and Condition",
                              style: AppTextStyle.s13_w5
                                  .copyWith(color: listColors.textMeidum))
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

  @override
  void didAuthenticated() {}

  @override
  void didAuthenticationFailed() {}

  @override
  void didChangeAccessToken() {}

  @override
  void didLock() {}

  @override
  void didRefershTokenExpired() {}

  @override
  void didUnauthenticated() {}

  @override
  void didUserRequestAccessVerification() {
    context.read<LoginCubit>().login(
          _userNameController.text,
          _passwordController.text,
        );
  }

  @override
  void didResetPasswordRequestAccessVertification() {}
}
