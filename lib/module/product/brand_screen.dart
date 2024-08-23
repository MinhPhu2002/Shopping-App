import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/core/values/sort_product_by.dart';
import 'package:testapp/module/cart/screen/cart_screen.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/constants/image_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_cubit.dart';
import 'package:testapp/module/detail/description_product_screen.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_cubit.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_state.dart';
import 'package:testapp/module/product/filter_bottom_sheet.dart';
import 'package:testapp/module/product/sort_bottom_sheet.dart';
import 'package:testapp/utils/ui/mediaquery_extention.dart';
import 'package:testapp/widget/circle_icon.dart';

class BrandScreen extends StatefulWidget {
  final String nameBrand;

  const BrandScreen({super.key, required this.nameBrand});
  @override
  State<BrandScreen> createState() => _BrandScreenState(nameBrand: nameBrand);
}

class _BrandScreenState extends State<BrandScreen> {
  late final BrandDetailsCubit brandDetailsCubit;
  late ScrollController controller;
  final String nameBrand;
  SortProductBy? sortBy;
  String? _priceFrom;
  String? _priceTo;
  _BrandScreenState({required this.nameBrand});

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
    // print(controller.position.extentAfter);
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(245, 246, 250, 1)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      nameBrand,
                      style: AppTextStyle.s17_w6,
                    ),
                  ),
                )),
          ],
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
      body: BlocBuilder<BrandDetailsCubit, BrandDetailsState>(
          builder: (context, state) {
        if (state.isLoading && state.brandDetails == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null && state.brandDetails == null) {
          print(state.errorMessage);
          return Center(child: Text(state.errorMessage!));
        }
        final data = state.brandDetails!;
        int count = state.totalItemCount!;

        return SizedBox(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$count Items",
                            style: AppTextStyle.s17_w5,
                          ),
                          Text(
                            "Available in stock",
                            style: AppTextStyle.s15_w4.copyWith(
                                color: Color.fromRGBO(143, 149, 158, 1)),
                          )
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showBotomSheetFilter();
                        },
                        child: Ink(
                          width: 37,
                          height: 37,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(245, 246, 250, 1)),
                          child: Center(
                            child: SvgPicture.asset(IconPath.filler),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showBottomSheetSort();
                        },
                        child: Ink(
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
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: (data.length / 2).ceil() + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == (data.length / 2).ceil()) {
                          if (state.errorMessage != null) {
                            return Text(state.errorMessage!);
                          }
                          if (state.hasMoreItem == false) {
                            return SizedBox();
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        int firstIndex = index * 2;
                        int secondIndex = firstIndex + 1;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 160,
                                  height: 258,
                                  child: ListItem(
                                    id: data[firstIndex].id,
                                    productImage: data[firstIndex].imageUrl,
                                    productCost: data[firstIndex].price,
                                    productName: data[firstIndex].name,
                                  ),
                                ),
                              ),
                              if (secondIndex < data.length)
                                SizedBox(width: 15), // Khoảng cách giữa 2 item
                              if (secondIndex < data.length)
                                Expanded(
                                  child: SizedBox(
                                    width: 160,
                                    height: 258,
                                    child: ListItem(
                                      id: data[secondIndex].id,
                                      productImage: data[secondIndex].imageUrl,
                                      productCost: data[secondIndex].price,
                                      productName: data[secondIndex].name,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }

  void showBottomSheetSort() async {
    final result = await showModalBottomSheet<SortProductBy>(
        context: context,
        builder: (context) {
          return SortBottomSheet(
            onChange: (value) {
              sortBy = value;
              brandDetailsCubit.sort(sortBy);
            },
            selectedValue: sortBy,
          );
        });
    // if (result != null) sortBy = result;
  }

  void showBotomSheetFilter() async {
    final result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: FilterBottomSheet(
                priceFrom: _priceFrom,
                priceTo: _priceTo,
                onchange: (priceFrom, priceTo) {
                  setState(() {
                    _priceFrom = priceFrom;
                    _priceTo = priceTo;
                  });
                  brandDetailsCubit.filter(
                      priceFrom: priceFrom, priceTo: priceTo);
                },
              ),
            ),
          );
        });
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
                child: DescriptionProductScreen(
                  postId: id,
                ),
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
                      color: Color.fromARGB(255, 212, 190, 197),
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
