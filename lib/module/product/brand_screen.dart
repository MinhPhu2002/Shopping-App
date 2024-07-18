import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/module/cart/cart_screen.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/constants/image_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_cubit.dart';
import 'package:testapp/module/detail/description_product_screen.dart';
import 'package:testapp/module/home/bloc/products/products_cubit.dart';
import 'package:testapp/module/home/bloc/products/products_state.dart';
import 'package:testapp/module/product/bloc/brand_details_cubit.dart';
import 'package:testapp/module/product/bloc/brand_details_state.dart';
import 'package:testapp/utils/ui/mediaquery_extention.dart';
import 'package:testapp/widget/circle_icon.dart';

class BrandScreen extends StatefulWidget {
  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  late final BrandDetailsCubit brandDetailsCubit;
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(_scrollListener);
    brandDetailsCubit = context.read<BrandDetailsCubit>();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 300) {
      brandDetailsCubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            child: CircleIcon(
              iconname: IconPath.back,
              colorCircle: const Color.fromRGBO(245, 246, 250, 1),
              sizeIcon: const Size(25, 25),
              sizeCircle: const Size(45, 45),
              colorBorder: Colors.transparent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Container(
          width: 68,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(245, 246, 250, 1)),
          child: Center(
            child: Image.asset(
              ImagePath.homeScreenIconNikeIllustrator,
              width: 48,
              height: 25,
            ),
          ),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              icon: CircleIcon(
                  iconname: IconPath.bag,
                  colorCircle: Color.fromRGBO(245, 246, 250, 1),
                  sizeIcon: Size(25, 25),
                  sizeCircle: Size(45, 45),
                  colorBorder: Colors.transparent)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "365 Items",
                        style: AppTextStyle.s17_w5,
                      ),
                      Text(
                        "Available in stock",
                        style: AppTextStyle.s15_w4
                            .copyWith(color: Color.fromRGBO(143, 149, 158, 1)),
                      )
                    ],
                  ),
                  Container(
                    width: 71,
                    height: 37,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(245, 246, 250, 1)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconPath.sort),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Sort",
                            style: AppTextStyle.s15_w5,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: BlocBuilder<BrandDetailsCubit, BrandDetailsState>(
                    builder: (context, state) {
                  if (state.isLoading && state.brandDetails == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.errorMessage != null &&
                      state.brandDetails == null) {
                    return Center(child: Text(state.errorMessage!));
                  }
                  final data = state.brandDetails!;

                  return GridView.builder(
                    controller: controller,
                    itemCount: data.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2,
                      childAspectRatio: 160 / 257,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == data.length) {
                        if (state.errorMessage != null) {
                          return Text(state.errorMessage!);
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var item = data[index];
                      return ListItem(
                        id: item.id,
                        productImage: item.imageUrl,
                        productCost: item.price,
                        productName: item.name,
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productCost;
  final int id;

  const ListItem(
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
                child: DescriptionProductScreen(),
              ),
            ));
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
                      color: Colors.white,
                      width: 20,
                      height: 20,
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
            '\$' + productCost,
            style: AppTextStyle.s13_w6
                .copyWith(color: const Color.fromRGBO(29, 30, 32, 1)),
          )
        ],
      ),
    );
  }
}
