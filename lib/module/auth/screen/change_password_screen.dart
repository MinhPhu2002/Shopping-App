// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/password_cubit.dart';
import 'package:testapp/module/auth/bloc/password_state.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldpassword = TextEditingController();

  TextEditingController _newPassword = TextEditingController();

  TextEditingController _confirmnewPassword = TextEditingController();
  @override
  void dispose() {
    _oldpassword.dispose();
    _newPassword.dispose();
    _confirmnewPassword.dispose();
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
                colorCircle: const Color.fromRGBO(245, 246, 250, 1),
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Change Password",
                style: AppTextStyle.s28_w6,
              ),
              Spacer(),
              NameList(
                Credentials: "Old Password",
                controller: _oldpassword,
              ),
              SizedBox(
                height: 20,
              ),
              NameList(
                Credentials: "New Password",
                controller: _newPassword,
              ),
              SizedBox(
                height: 20,
              ),
              NameList(
                Credentials: "Confirm New Password",
                controller: _confirmnewPassword,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 36, right: 36, bottom: 20),
                child: Text(
                  "Please write your new password.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.s13_w4
                      .copyWith(color: Color.fromRGBO(143, 149, 158, 1)),
                ),
              ),
              BlocListener<PasswordCubit, PasswordState>(
                listener: (context, state) {
                  if (state is PasswordLoadingInProgress) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is ChangePassWordSuccess) {
                    context.pop();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Thông báo'),
                        content: Text('Đổi mật khẩu thành công'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ChangePasswordLoadingError) {
                    context.pop();
                    showDialog(
                      context: context,
                      builder: (context) => Text(state.error),
                    );
                  }
                },
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (_newPassword.text != _confirmnewPassword.text) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Lỗi'),
                content: Text('Mật khẩu chưa khớp'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } else
            context.read<PasswordCubit>().changePassword(
                oldPassword: _oldpassword.text, newPassword: _newPassword.text);
        },
        child: const FootPage(
          textfootpage: 'Reset Password',
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
  final String Credentials;
  final TextEditingController controller;
  const NameList(
      {super.key, required this.Credentials, required this.controller});
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
            controller: controller,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: Credentials,
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
