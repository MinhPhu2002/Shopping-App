import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/app_authentication.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/constants/image_path.dart';
import 'package:testapp/core/theme/app_color_theme.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/password_cubit.dart';
import 'package:testapp/module/auth/bloc/password_state.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/credential.dart';
import 'package:testapp/widget/foot_page.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    implements AppAuthenticationBindingObserver {
  TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    AppAuthenticationBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    AppAuthenticationBinding.instance?.removeObserver(this);
    usernameController.dispose();
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
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot Password",
                      style: AppTextStyle.s28_w6
                          .copyWith(color: listColors.textMeidum),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 68),
                  child: Image.asset(ImagePath.forgotPasswordIllustrator),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Credential(
                          credentials: "Username",
                          obscureText: false,
                          data: usernameController)
                    ],
                  ),
                ),
                BlocListener<PasswordCubit, PasswordState>(
                  listener: (context, state) {
                    if (state is PasswordLoadingInProgress) {
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                            child: const CircularProgressIndicator()),
                      );
                    } else if (state is ForgotPassWordSuccess) {
                      context.pop();
                      context.pushNamed('vertifyForgotPassword', extra: {
                        'username': usernameController.text,
                      });
                    } else if (state is ForgotPasswordLoadingError) {
                      context.pop();
                      showDialog(
                        context: context,
                        builder: (context) => Text(state.error),
                      );
                    }
                  },
                  child: const SizedBox(),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 25),
            child: Text(
              "Please write your email to receive a confirmation code to set a new password.",
              textAlign: TextAlign.center,
              style: AppTextStyle.s13_w4
                  .copyWith(color: const Color.fromRGBO(143, 149, 158, 1)),
            ),
          ),
          InkWell(
            onTap: () {
              context
                  .read<PasswordCubit>()
                  .forgotpassword(username: usernameController.text);
            },
            child: const FootPage(
              textfootpage: 'Confirm Mail',
            ),
          ),
        ],
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
  void didUserRequestAccessVerification() {}

  @override
  void didResetPasswordRequestAccessVertification() {
    context
        .read<PasswordCubit>()
        .forgotpassword(username: usernameController.text);
  }
}
