import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/cart/screen/cart_screen.dart';
import 'package:testapp/module/product/wishlish_screen.dart';

class FootHomePage extends StatelessWidget {
  const FootHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {},
            child: Text(
              "Home",
              style: AppTextStyle.s11_w5
                  .copyWith(color: const Color.fromRGBO(151, 117, 250, 1)),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WishlishScreen(),
                    ));
              },
              icon: SvgPicture.asset(
                IconPath.heart,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              icon: SvgPicture.asset(
                IconPath.bag,
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(143, 149, 158, 1), BlendMode.srcIn),
              )),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              IconPath.wallet,
            ),
          ),
        ],
      ),
    );
  }
}
