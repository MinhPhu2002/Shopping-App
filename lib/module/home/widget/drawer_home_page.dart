import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/common/app_setting.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/core/theme/app_color_theme.dart';
import 'package:testapp/data/services/auth_service.dart';
import 'package:testapp/module/home/bloc/user/user_cubit.dart';
import 'package:testapp/module/home/bloc/user/user_state.dart';
import 'package:testapp/module/home/home_screen.dart';
import 'package:testapp/module/product/wishlish_screen.dart';
import 'package:testapp/widget/circle_icon.dart';

class DrawerHomePage extends StatelessWidget {
  const DrawerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: BlocProvider(
        create: (context) => UserCubit(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoadingInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserLoadingError) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            final data = (state as UserLoaded).user;

            return HomeDrawer(avatar: data.avatar, name: data.name);
          },
        ),
      ),
    );
  }
}

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    super.key,
    required this.avatar,
    required this.name,
  });

  final String avatar;
  final String name;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool darkmode = false;
  @override
  void initState() {
    // TODO: implement initState
    loadtheme();
    super.initState();
  }

  void loadtheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      darkmode = preferences.getBool('darkmode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColorTheme listColors =
        Theme.of(context).extension<AppColorTheme>()!;
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      width: 300,
      backgroundColor: listColors.background,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: CircleIcon(
                  iconname: IconPath.menu2,
                  colorCircle: listColors.colorBox!,
                  sizeIcon: const Size(25, 25),
                  sizeCircle: const Size(45, 45),
                  colorBorder: Colors.transparent),
              onTap: () => Scaffold.of(context).closeDrawer(),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                if (widget.avatar.isNotEmpty)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(widget.avatar),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (widget.avatar.isEmpty)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      IconPath.avatarDefault,
                      color: listColors.textMeidum,
                    ),
                  ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTextStyle.s15_w5
                          .copyWith(color: listColors.textMeidum),
                    ),
                    const SizedBox(width: 7),
                    Row(
                      children: [
                        Text("Verified Profile",
                            style: AppTextStyle.s11_w5
                                .copyWith(color: listColors.textSmall)),
                        const SizedBox(width: 5),
                        SvgPicture.asset(IconPath.badge),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: 66,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: listColors.colorBox),
                  child: Center(
                      child: Text(
                    "3 Orders",
                    style: AppTextStyle.s11_w5
                        .copyWith(color: listColors.textSmall),
                  )),
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const ListMenu(icon: IconPath.sun, name: "Dark Mode"),
                Ink(
                  width: 45,
                  height: 25,
                  decoration: const BoxDecoration(),
                  child: CupertinoSwitch(
                    value: darkmode,
                    activeColor: darkmode
                        ? Colors.green
                        : Color.fromRGBO(214, 214, 214, 1),
                    onChanged: (bool value) async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      setState(() {
                        darkmode = !darkmode;
                        value = darkmode;
                        pref.setBool('darkmode', darkmode);
                        if (darkmode == true)
                          AppSetting.enableDarkMode();
                        else
                          AppSetting.disableDarkMode();
                      });
                    },
                  ),
                )
              ],
            ),
            const ListMenu(icon: IconPath.point, name: "Account Information"),
            InkWell(
                onTap: () {
                  context.pushNamed('changepassword');
                },
                child: const ListMenu(icon: IconPath.lock, name: "Password")),
            InkWell(
                onTap: () {
                  context.pop();
                  context.pushNamed('cart');
                },
                child: const ListMenu(icon: IconPath.bag, name: "Order")),
            const ListMenu(icon: IconPath.wallet, name: "My Cards"),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlishScreen(),
                        settings: const RouteSettings(name: 'wishlishscreen'),
                      ));
                },
                child: const ListMenu(icon: IconPath.heart, name: "Wishlist")),
            const ListMenu(icon: IconPath.setting, name: "Settings"),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  AuthService.instance.invalid();

                  context.goNamed('/');
                },
                child: Container(
                  width: 215,
                  height: 45,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconPath.logout,
                        color: const Color.fromRGBO(255, 87, 87, 1),
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: AppTextStyle.s15_w4.copyWith(
                            color: const Color.fromRGBO(255, 87, 87, 1)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
