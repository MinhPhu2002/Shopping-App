import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/auth/bloc/login_cubit.dart';
import 'package:testapp/module/auth/screen/login_screen.dart';
import 'package:testapp/module/auth/screen/signup_screen.dart';
import 'package:testapp/module/home/bloc/brands/brands_cubit.dart';
import 'package:testapp/module/home/bloc/products/products_cubit.dart';
import 'package:testapp/module/home/bloc/user/user_cubit.dart';
import 'package:testapp/module/home/home_screen.dart';
import 'package:testapp/widget/bottom_action_button.dart';
import 'package:testapp/widget/circle_icon.dart';

import '../../../core/constants/icon_path.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({
    super.key,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuthen =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuthen.accessToken,
        idToken: googleAuthen.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5, left: 20),
          child: InkWell(
            child: CircleIcon(
                iconname: IconPath.back,
                colorCircle: const Color.fromRGBO(245, 246, 250, 1),
                sizeIcon: const Size(25, 25),
                sizeCircle: const Size(45, 45),
                colorBorder: Colors.transparent),
            onTap: () {},
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's Get Started",
                      style: AppTextStyle.s28_w6,
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: const Alignment(0, 185 / 559),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const InkWellExample(
                          nameIcon: FontAwesomeIcons.facebook,
                          backGroundColor: Color.fromRGBO(66, 103, 178, 1),
                          label: 'Facebook',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const InkWellExample(
                          backGroundColor: Color.fromRGBO(29, 161, 242, 1),
                          label: 'Twitter',
                          nameIcon: FontAwesomeIcons.twitter,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            User? user = await _signInWithGoogle();
                            if (user != null) {
                              print(
                                  'Signed in with Google: ${user.displayName}');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    settings: const RouteSettings(name: 'Home'),
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
                            }
                          },
                          child: const InkWellExample(
                            nameIcon: FontAwesomeIcons.google,
                            backGroundColor: Color.fromRGBO(234, 67, 53, 1),
                            label: 'Google',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => LoginCubit(),
                      child: const LoginScreen(),
                    ),
                  ));
            },
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Already have an account? ",
                  style: AppTextStyle.s15_w4
                      .copyWith(color: const Color.fromRGBO(143, 149, 158, 1))),
              const TextSpan(
                text: "Signin",
                style: AppTextStyle.s15_w5,
              )
            ])),
          ),
          const SizedBox(
            height: 25,
          ),
          BottomActionButton(
              textfootpage: 'Create an Account',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ));
              })
        ],
      ),
    );
  }
}

/// This class represents an example of using the InkWell widget in a Flutter application.
class InkWellExample extends StatelessWidget {
  const InkWellExample(
      {super.key,
      required this.backGroundColor,
      required this.label,
      required this.nameIcon});
  final IconData nameIcon;
  final Color backGroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            nameIcon,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: AppTextStyle.s17_w6.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
