import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/data/services/auth_service.dart';
import 'package:testapp/module/cart/bloc/cart_cubit.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_cubit.dart';
import 'package:testapp/module/home/bloc/brands/brands_cubit.dart';
import 'package:testapp/module/home/bloc/brands/brands_state.dart';
import 'package:testapp/module/home/bloc/products/products_cubit.dart';
import 'package:testapp/module/home/bloc/products/products_state.dart';
import 'package:testapp/module/home/bloc/user/user_cubit.dart';
import 'package:testapp/module/home/bloc/user/user_state.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_cubit.dart';
import 'package:testapp/module/product/brand_screen.dart';
import 'package:testapp/module/cart/screen/cart_screen.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/constants/image_path.dart';
import 'package:testapp/core/constants/product_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/detail/description_product_screen.dart';
import 'package:testapp/module/auth/screen/start_screen.dart';
import 'package:testapp/utils/ui/mediaquery_extention.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'dart:ui' show ImageFilter;

import 'package:testapp/module/product/wishlish_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            padding: const EdgeInsets.only(left: 20),
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: CircleIcon(
                iconname: IconPath.menu,
                colorCircle: const Color.fromRGBO(245, 246, 250, 1),
                sizeIcon: const Size(25, 25),
                sizeCircle: const Size(45, 45),
                colorBorder: Colors.transparent),
          );
        }),
        actions: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => CartCubit(),
                        child: CartScreen(),
                      ),
                    ));
              },
              icon: CircleIcon(
                  iconname: IconPath.bag,
                  colorCircle: const Color.fromRGBO(245, 246, 250, 1),
                  sizeIcon: const Size(25, 25),
                  sizeCircle: const Size(45, 45),
                  colorBorder: Colors.transparent)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      drawerScrimColor: const Color.fromRGBO(29, 30, 32, 0.2),
      drawer: const DrawerHomePage(),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Hemendra",
                  style: AppTextStyle.s28_w6,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "Welcome to Laza.",
                      style: AppTextStyle.s15_w4.copyWith(
                          color: const Color.fromRGBO(143, 149, 158, 1)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  children: [
                    Expanded(child: Search()),
                    SizedBox(
                      width: 10,
                    ),
                    VoiceIcon(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ViewAll(nameViewAll: "Choose Brand"),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: BlocBuilder<BrandsCubit, BrandsState>(
                    builder: (context, state) {
                  if (state is BrandsLoadingInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is BrandsLoadingError) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  final data = (state as BrandsLoaded).brands;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: data.map((item) {
                        return Brand(
                          iconBrand: item.imageUrl,
                          nameBrand: item.name,
                          slug: item.slug,
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              const ViewAll(nameViewAll: "New Arraival"),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoadingInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductsLoadingError) {
                    return Center(child: Text(state.errorMessage));
                  }
                  final data = (state as ProductsLoaded).products;
                  return GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      childAspectRatio: 160 / 257,
                      children: data.map(
                        (item) {
                          return NewArraival(
                            productImage: item.imageUrl,
                            productName: item.title,
                            productCost: item.price.toString(),
                            id: item.id,
                          );
                        },
                      ).toList());
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FootHomePage(),
    );
  }
}

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
              // return Text(state.errorMessage);
              return HomeDrawer(avatar: '', name: '');
            }
            final data = (state as UserLoaded).user;

            return HomeDrawer(
                avatar: data.avatar, name: data.firstName + data.lastName);
          },
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.avatar,
    required this.name,
  });

  final String avatar;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      width: 300,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: CircleIcon(
                  iconname: IconPath.menu2,
                  colorCircle: const Color.fromRGBO(245, 245, 245, 1),
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
                          image: NetworkImage(avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyle.s15_w5,
                    ),
                    const SizedBox(width: 7),
                    Row(
                      children: [
                        Text("Verified Profile",
                            style: AppTextStyle.s11_w5.copyWith(
                                color: const Color.fromRGBO(143, 149, 158, 1))),
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
                      color: const Color.fromRGBO(245, 245, 245, 1)),
                  child: const Center(
                      child: Text(
                    "3 Orders",
                    style: AppTextStyle.s11_w5,
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
                    value: false,
                    activeColor: const Color.fromRGBO(214, 214, 214, 1),
                    onChanged: (bool value) {},
                  ),
                )
              ],
            ),
            const ListMenu(icon: IconPath.point, name: "Account Information"),
            const ListMenu(icon: IconPath.lock, name: "Password"),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
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
                onTap: () {
                  AuthService.instance.invalid();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StartScreen()),
                    (Route<dynamic> route) => false,
                  );
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

class ListMenu extends StatelessWidget {
  final String icon;
  final String name;

  const ListMenu({super.key, required this.icon, required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      padding: const EdgeInsets.only(top: 5),
      height: 45,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            color: Colors.black,
            width: 25,
            height: 25,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: AppTextStyle.s15_w4
                .copyWith(color: const Color.fromRGBO(29, 30, 32, 1)),
          )
        ],
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(245, 246, 250, 1),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: "Search...",
          hintStyle: const TextStyle(
              fontSize: 17, color: Color.fromRGBO(143, 149, 158, 1)),
          prefixIcon: SvgPicture.asset(
            IconPath.search,
            width: 20,
            height: 20,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}

class VoiceIcon extends StatelessWidget {
  const VoiceIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(151, 117, 250, 1),
            borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          icon: SvgPicture.asset(
            IconPath.voice,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class Brand extends StatelessWidget {
  final String iconBrand;
  final String nameBrand;
  final String slug;

  const Brand(
      {super.key,
      required this.iconBrand,
      required this.nameBrand,
      required this.slug});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BrandDetailsCubit(slug),
                child: BrandScreen(
                  nameBrand: nameBrand,
                ),
              ),
              settings: const RouteSettings(name: "brand"),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 246, 250, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 10,
              ),
              Ink(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(image: NetworkImage(iconBrand)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                nameBrand,
                style: AppTextStyle.s15_w5,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewArraival extends StatelessWidget {
  final int id;
  final String productImage;
  final String productName;
  final String productCost;

  const NewArraival(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productCost,
      required this.id});
  @override
  Widget build(BuildContext context) {
    final imageSize =
        context.getResponSizeBasOnWidth(designWidth: 160, designHeight: 203);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => ProductDetailsCubit(id),
                    child: DescriptionProductScreen(
                      postId: id,
                    ),
                  ),
              settings: const RouteSettings(name: "description")),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: imageSize.width,
                height: imageSize.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(productImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 6,
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      ImagePath.homeScreenHeartIconIllustrator,
                      color: const Color.fromARGB(255, 212, 190, 197),
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            overflow: TextOverflow.ellipsis,
            productName,
            style: AppTextStyle.s11_w5,
          ),
          const SizedBox(height: 5),
          Text(
            "\$" + productCost,
            style: AppTextStyle.s13_w6
                .copyWith(color: const Color.fromRGBO(29, 30, 32, 1)),
          )
        ],
      ),
    );
  }
}

class ViewAll extends StatelessWidget {
  final String nameViewAll;

  const ViewAll({super.key, required this.nameViewAll});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameViewAll,
            style: AppTextStyle.s17_w5
                .copyWith(color: const Color.fromRGBO(29, 30, 32, 1)),
          ),
          const Text(
            "View All",
            style: TextStyle(
                color: Color.fromRGBO(143, 149, 158, 1), fontSize: 13),
          )
        ],
      ),
    );
  }
}

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
