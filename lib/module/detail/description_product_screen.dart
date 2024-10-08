import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:testapp/common/model/product_model.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/constants/product_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_cubit.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_state.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/comment.dart';
import 'package:testapp/widget/foot_page.dart';

class DescriptionProductScreen extends StatelessWidget {
  const DescriptionProductScreen({super.key, required this.postId});
  final int postId;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            child: CircleIcon(
                iconname: IconPath.back,
                colorCircle: Color.fromRGBO(245, 246, 250, 1),
                sizeIcon: const Size(25, 25),
                sizeCircle: const Size(45, 45),
                colorBorder: Colors.transparent),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed('cart');
            },
            icon: CircleIcon(
                iconname: IconPath.bag,
                colorCircle: Color.fromRGBO(245, 246, 250, 1),
                sizeIcon: const Size(25, 25),
                sizeCircle: const Size(45, 45),
                colorBorder: Colors.transparent),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoadingInProgress) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductDetailsLoadingError) {
            return Center(child: Text(state.errorMessage));
          }
          final data = (state as ProductDetailsLoaded).productDetails;
          return Body(
            model: data,
            postId: postId,
          );
        },
      ),
    );
  }
}

class Body extends StatefulWidget {
  final int postId;
  final ProductDetailsModel model;

  Body({super.key, required this.model, required this.postId});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedSizeIndex = -1;
  int selectedColorId = -1;
  bool stockColor = false;
  bool stockSize = false;
  Widget numberItems() {
    if (selectedColorId != -1 && selectedSizeIndex != -1) {
      for (var variant in widget.model.variants) {
        if (selectedColorId == variant.option_ids[0] &&
            selectedSizeIndex == variant.option_ids[1]) {
          if (variant.stock >= 5) {
            return Row(
              children: [
                SvgPicture.asset(
                  IconPath.infoCircle,
                  color: Color.fromRGBO(143, 149, 158, 1),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '${variant.stock.toString()} in stock',
                  style: AppTextStyle.s13_w5
                      .copyWith(color: Color.fromRGBO(143, 149, 158, 1)),
                ),
              ],
            );
          } else
            return Row(
              children: [
                SvgPicture.asset(
                  IconPath.infoCircle,
                  color: Color.fromRGBO(198, 75, 77, 1),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Only ${variant.stock.toString()} left',
                  style: AppTextStyle.s13_w5
                      .copyWith(color: Color.fromRGBO(198, 75, 77, 1)),
                ),
              ],
            );
        }
      }
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ColoredBox(color: Color.fromRGBO(245, 246, 250, 1)),
          Padding(
            padding: EdgeInsets.only(top: 31),
            child: Container(
              height: 347,
              child: Image.network(
                widget.model.imageUrl[0],
                fit: BoxFit.fitHeight,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Text(
                          widget.model.title,
                          style: AppTextStyle.s13_w4.copyWith(
                              color: const Color.fromRGBO(143, 149, 158, 1)),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Price",
                        style: AppTextStyle.s13_w4.copyWith(
                            color: const Color.fromRGBO(143, 149, 158, 1)),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.model.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.s22_w6.copyWith(
                              color: const Color.fromRGBO(29, 30, 32, 1)),
                        ),
                      ),
                      Text(
                        '\$' + widget.model.price,
                        style: AppTextStyle.s22_w6.copyWith(
                            color: const Color.fromRGBO(29, 30, 32, 1)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.model.imageUrl.map(
                        (url) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 9),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: 77,
                              height: 77,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                url,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Size",
                        style: AppTextStyle.s17_w6.copyWith(
                            color: const Color.fromRGBO(29, 30, 32, 1)),
                      ),
                      Text(
                        "Size Guide ",
                        style: AppTextStyle.s15_w4.copyWith(
                            color: const Color.fromRGBO(143, 149, 158, 1)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  // ignore: prefer_const_constructors
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.model.productSizes.map((productSize) {
                        for (var variant in widget.model.variants) {
                          if (selectedColorId == -1 &&
                                  variant.option_ids.contains(productSize.id) &&
                                  variant.stock != 0 ||
                              selectedColorId != -1 &&
                                  variant.option_ids.contains(productSize.id) &&
                                  variant.option_ids
                                      .contains(selectedColorId) &&
                                  variant.stock != 0) {
                            stockSize = true;
                            break;
                          }
                          stockSize = false;
                        }
                        return ProductSize(
                          size: productSize.name,
                          ontap: () {
                            setState(() {
                              if (selectedSizeIndex != productSize.id)
                                selectedSizeIndex = productSize.id;
                              else
                                selectedSizeIndex = -1;
                            });
                          },
                          selectedIndex: selectedSizeIndex == productSize.id,
                          stock: stockSize,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Color",
                        style: AppTextStyle.s17_w6.copyWith(
                            color: const Color.fromRGBO(29, 30, 32, 1)),
                      ),
                      numberItems(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // ignore: prefer_const_constructors
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.model.productColors.map((productcolor) {
                        for (var variant in widget.model.variants) {
                          if (selectedSizeIndex == -1 &&
                                  variant.option_ids
                                      .contains(productcolor.id) &&
                                  variant.stock != 0 ||
                              selectedSizeIndex != -1 &&
                                  variant.option_ids
                                      .contains(productcolor.id) &&
                                  variant.stock != 0 &&
                                  variant.option_ids
                                      .contains(selectedSizeIndex)) {
                            stockColor = true;
                            break;
                          }
                          stockColor = false;
                        }
                        return ColorProduct(
                          color: productcolor.colorCode,
                          nameColor: productcolor.name,
                          ontap: () {
                            setState(() {
                              if (selectedColorId != productcolor.id)
                                selectedColorId = productcolor.id;
                              else
                                selectedColorId = -1;
                            });
                          },
                          selectedIndex: selectedColorId == productcolor.id,
                          stock: stockColor,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: AppTextStyle.s17_w6,
                  ),
                  const SizedBox(height: 10),
                  ReadMoreText(
                    widget.model.description,
                    textAlign: TextAlign.left,
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    style: AppTextStyle.s15_w4.copyWith(
                      color: const Color.fromRGBO(143, 149, 158, 1),
                    ),
                    colorClickableText: Colors.black,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Show less',
                    lessStyle:
                        AppTextStyle.s15_w6.copyWith(color: Colors.black),
                    moreStyle:
                        AppTextStyle.s15_w6.copyWith(color: Colors.black),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review",
                        style: AppTextStyle.s17_w6.copyWith(
                            color: const Color.fromRGBO(29, 30, 32, 1)),
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed('review',
                              extra: {'id': widget.postId});
                        },
                        child: Text("View All",
                            style: AppTextStyle.s13_w4.copyWith(
                              color: const Color.fromRGBO(143, 149, 158, 1),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const CommentProduct(
              avatar: ProductPath.avatar2,
              name: "Guy Hawkins",
              time: '13 Sep, 2020',
              ratingScore: 4,
              comment:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet..."),
          InkWell(
            child: FootPage(
              textfootpage: 'Add to Cart',
            ),
          ),
        ],
      ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  final String PathProductInformation;

  const ProductInformation({super.key, required this.PathProductInformation});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Container(
        width: (MediaQuery.sizeOf(context).width - 67) / 4,
        height: (MediaQuery.sizeOf(context).width - 67) / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(PathProductInformation), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class ProductSize extends StatefulWidget {
  final String size;
  final VoidCallback ontap;
  final bool selectedIndex;
  final bool stock;
  const ProductSize(
      {super.key,
      required this.size,
      required this.ontap,
      required this.selectedIndex,
      required this.stock});

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: GestureDetector(
        onTap: () {
          if (widget.stock) widget.ontap();
        },
        child: Container(
          width: (MediaQuery.sizeOf(context).width - 76) / 5,
          height: (MediaQuery.sizeOf(context).width - 76) / 5,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.selectedIndex
                  ? Color.fromRGBO(151, 117, 250, 1)
                  : Colors.transparent,
              width: widget.selectedIndex ? 2.0 : 1.0,
            ),
            color: const Color.fromRGBO(245, 246, 250, 1)
                .withOpacity(widget.stock ? 1.0 : 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.size,
              style: AppTextStyle.s17_w6.copyWith(
                  color: Colors.black.withOpacity(widget.stock ? 1.0 : 0.4)),
            ),
          ),
        ),
      ),
    );
  }
}

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 7) {
    buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
  }
  return Color(int.parse(buffer.toString(), radix: 16));
}

Color bordercolor(String nameColor) {
  if (nameColor.toLowerCase().contains('white'))
    return Color.fromRGBO(222, 222, 222, 1);
  else
    return Colors.transparent;
}

class ColorProduct extends StatefulWidget {
  final String color;
  final String nameColor;
  final VoidCallback ontap;
  final bool selectedIndex;
  final bool stock;
  const ColorProduct(
      {super.key,
      required this.color,
      required this.nameColor,
      required this.ontap,
      required this.selectedIndex,
      required this.stock});

  @override
  State<ColorProduct> createState() => _ColorProductState();
}

class _ColorProductState extends State<ColorProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: GestureDetector(
        onTap: () {
          if (widget.stock) widget.ontap();
        },
        child: Container(
          width: (MediaQuery.sizeOf(context).width - 76) / 5,
          height: (MediaQuery.sizeOf(context).width - 76) / 5,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.selectedIndex
                  ? Color.fromRGBO(151, 117, 250, 1)
                  : bordercolor(widget.nameColor),
              width: widget.selectedIndex ? 2.0 : 1.0,
            ),
            color:
                hexToColor(widget.color).withOpacity(widget.stock ? 1.0 : 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
