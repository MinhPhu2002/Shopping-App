import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/register_cubit.dart';
import 'package:testapp/module/auth/bloc/register_state.dart';
import 'package:testapp/widget/bottom_action_button.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/switch_widget.dart';
import 'package:testapp/widget/will_unfocus_form_scope.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late final RegisterCubit register;
  bool checkUserName = true;
  bool checkEmail = true;
  final GlobalKey<FormFieldState> key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    register = context.read<RegisterCubit>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _passWordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scaleHeight = MediaQuery.sizeOf(context).height / 812;
    // TODO: implement build
    return WillUnfocusFormScope(
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: InkResponse(
              onTap: () {
                context.pop();
                // context.pushNamed('/');
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UniqueValueField(
                              controller: _userNameController,
                              checkExist: register.checkUsernNameExist,
                              label: 'Username',
                              existsMessage: 'UserName already exists'),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            controller: _passWordController,
                            label: 'Password',
                            borderColor: Colors.grey,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          UniqueValueField(
                            controller: _emailController,
                            checkExist: register.checkEmailExist,
                            label: 'Email',
                            existsMessage: 'Email already exists',
                            validator: (value) {
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value!)) return 'Email not valid';
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 20),
                            child: SwitchWidget(nameSwitch: "Remember me"),
                          ),
                          BlocListener<RegisterCubit, RegisterState>(
                            listener: (context, state) {
                              if (state is RegisterLoadingInProgress) {
                                showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else if (state is RegisterSuccess) {
                                context.goNamed('home');
                              } else if (state is RegisterLoadingError) {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      Text(state.errorMessage),
                                );
                              }
                            },
                            child: SizedBox(),
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
                context.read<RegisterCubit>().register(
                      _userNameController.text,
                      _passWordController.text,
                      _emailController.text,
                    );
              })),
    );
  }
}

class UniqueValueField extends StatefulWidget {
  const UniqueValueField(
      {super.key,
      required this.controller,
      required this.checkExist,
      required this.label,
      required this.existsMessage,
      this.validator});
  final TextEditingController controller;
  final Future<bool> Function(String? data) checkExist;
  final String label;
  final String existsMessage;
  final FormFieldValidator<String>? validator;
  @override
  State<UniqueValueField> createState() => _UniqueValueFieldState();
}

class _UniqueValueFieldState extends State<UniqueValueField> {
  final GlobalKey<FormFieldState> key = GlobalKey();
  bool isDataExist = false;
  late FocusNode _focusNode;
  String _lateValue = '';
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(handleFocusChange);
  }

  void handleFocusChange() async {
    if (!_focusNode.hasFocus && widget.controller.text != _lateValue) {
      _lateValue = widget.controller.text;
      isDataExist = await widget.checkExist(_lateValue);
      key.currentState!.validate();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        if (isDataExist) {
          return widget.existsMessage;
        }
        return widget.validator?.call(value);
      },
      controller: widget.controller,
      label: widget.label,
      borderColor: key.currentState != null && key.currentState!.isValid
          ? Colors.green
          : Colors.grey,
      formKey: key,
      focusNode: _focusNode,
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.validator,
      required this.controller,
      required this.label,
      required this.borderColor,
      this.formKey,
      this.obscureText = false,
      this.focusNode});
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String label;
  final Color borderColor;
  final GlobalKey<FormFieldState>? formKey;
  final bool obscureText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // onFieldSubmitted: widget.onFieldSubmitted,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: label,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red))),
        obscureText: obscureText,
      ),
    );
  }
}
