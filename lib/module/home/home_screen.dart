import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/home/bloc/brands/brands_cubit.dart';
import 'package:testapp/module/home/bloc/brands/brands_state.dart';
import 'package:testapp/module/home/bloc/products/products_cubit.dart';
import 'package:testapp/module/home/bloc/products/products_state.dart';
import 'package:testapp/module/home/widget/brand.dart';
import 'package:testapp/module/home/widget/drawer_home_page.dart';
import 'package:testapp/module/home/widget/foot_home_page.dart';
import 'package:testapp/module/home/widget/search.dart';
import 'package:testapp/module/home/widget/view_catalog.dart';
import 'package:testapp/module/home/widget/voice_icon.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/list_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductsCubit productsCubit;
  String? search;
  @override
  void initState() {
    productsCubit = context.read<ProductsCubit>();
    super.initState();
  }

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
                context.pushNamed('cart');
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
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  children: [
                    Expanded(child: Search(
                      onchange: (value) {
                        search = value;
                        productsCubit.search(search: search);
                      },
                    )),
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
              const ViewCatalog(nameView: "Choose Brand"),
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
              const ViewCatalog(nameView: "New Arraival"),
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
                          return ListProducts(
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
