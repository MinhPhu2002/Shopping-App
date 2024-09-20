import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:testapp/core/constants/image_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/vertify_cubit.dart';
import 'package:testapp/module/auth/bloc/vertify_state.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';

import '../../../core/constants/icon_path.dart';

class VertificationCodeScreen extends StatefulWidget {
  const VertificationCodeScreen({
    super.key,
    required this.username,
    required this.onResentOtp,
  });
  final String username;
  final VoidCallback onResentOtp;
  @override
  State<VertificationCodeScreen> createState() =>
      _VertificationCodeScreenState();
}

class _VertificationCodeScreenState extends State<VertificationCodeScreen> {
  final TextEditingController otpController = TextEditingController();
  int startTimer = 30;
  Timer? timer;
  void countTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (startTimer > 0) {
          startTimer--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  String formatTimer(int timer) {
    int minutes = timer ~/ 60;
    int seconds = timer % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void initState() {
    countTimer();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    timer?.cancel();
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
                child: OtpInput(
                  otp: otpController,
                ),
              ),
              BlocListener<VertifyCubit, VertifyState>(
                listener: (context, state) {
                  if (state is VertifyLoadingInProgress) {
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                          child: const CircularProgressIndicator()),
                    );
                  } else if (state is VertifySuccess) {
                    context.pop();
                    context.pushNamed('home');
                  } else if (state is VertifyLoadingError) {
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
                child: SizedBox(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 36, right: 36, bottom: 25),
              child: InkWell(
                onTap: () {
                  if (startTimer == 0) {
                    startTimer = 30;
                    countTimer();
                    widget.onResentOtp();
                  }
                },
                child: Text.rich(TextSpan(children: [
                  if (startTimer > 0)
                    TextSpan(
                      text: formatTimer(startTimer),
                      style: AppTextStyle.s13_w5,
                    ),
                  TextSpan(
                      text: " resend confirmation code.",
                      style: AppTextStyle.s13_w4.copyWith(
                          color: const Color.fromRGBO(143, 149, 158, 1))),
                ])),
              )),
          InkWell(
            onTap: () {
              context.read<VertifyCubit>().vertifyOtp(
                  username: widget.username, otp: otpController.text);
            },
            child: const FootPage(
              textfootpage: 'Confirm Code',
            ),
          ),
        ],
      ),
    ));
  }
}

class SwitchState extends StatelessWidget {
  const SwitchState({super.key});

  @override
  Widget build(BuildContext context) {
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
  final TextEditingController otp;

  const OtpInput({super.key, required this.otp});
  @override
  Widget build(BuildContext context) {
    // TODO: implement createState
    return PinCodeTextField(
      controller: otp,
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
