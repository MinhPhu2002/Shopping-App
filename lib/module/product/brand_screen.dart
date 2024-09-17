import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/common/model/filter_request_model.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/core/values/sort_product_by.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_cubit.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_state.dart';
import 'package:testapp/module/product/widget/filter_bottom_sheet.dart';
import 'package:testapp/module/product/widget/sort_bottom_sheet.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/list_products.dart';

class BrandScreen extends StatefulWidget {
  final String nameBrand;

  const BrandScreen({super.key, required this.nameBrand});
  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  late final BrandDetailsCubit brandDetailsCubit;
  late ScrollController controller;
  FilterRequestModel filter = FilterRequestModel();

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
                      widget.nameBrand,
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
                context.pushNamed('cart');
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
                          return SizedBox(
                            height: 60,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
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
                                  child: ListProducts(
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
                                    child: ListProducts(
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
              filter.sortBy = value;
              brandDetailsCubit.sort(filter.sortBy);
            },
            selectedValue: filter.sortBy,
          );
        });
    // if (result != null) sortBy = result;
  }

  void showBotomSheetFilter() async {
    final result = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FilterBottomSheet(
              priceFrom: filter.priceFrom,
              priceTo: filter.priceTo,
              onchange: (priceFrom, priceTo) {
                setState(() {
                  filter.priceFrom = priceFrom;
                  filter.priceTo = priceTo;
                });
                brandDetailsCubit.filter(
                    priceFrom: priceFrom, priceTo: priceTo);
              },
            ),
          );
        });
  }
}
