import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:testapp/common/model/product_model.dart';
import 'package:testapp/module/cart/cart_screen.dart';
import 'package:testapp/core/constants/product_path.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_cubit.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_state.dart';
import 'package:testapp/module/review/bloc/comment_cubit.dart';
import 'package:testapp/module/review/review_screen.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/comment.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
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

class Body extends StatelessWidget {
  final int postId;
  final ProductDetailsModel model;

  const Body({super.key, required this.model, required this.postId});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ColoredBox(color: Color.fromRGBO(245, 246, 250, 1)),
          Padding(
            padding: EdgeInsets.only(top: 31),
            child: Image.network(
              model.imageUrl[0],
              fit: BoxFit.fitWidth,
              width: double.infinity,
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
                          model.title,
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
                          model.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.s22_w6.copyWith(
                              color: const Color.fromRGBO(29, 30, 32, 1)),
                        ),
                      ),
                      Text(
                        '\$' + model.price,
                        style: AppTextStyle.s22_w6.copyWith(
                            color: const Color.fromRGBO(29, 30, 32, 1)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: model.imageUrl.map(
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
                    child: const Row(
                      children: [
                        ProductSize(size: "S"),
                        ProductSize(size: "M"),
                        ProductSize(size: "L"),
                        ProductSize(size: "Xl"),
                        ProductSize(size: "2XL"),
                        ProductSize(size: "3XL"),
                      ],
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
                    model.description,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => CommentCubit(postId),
                                  child: ReviewScreen(
                                    postId: postId,
                                  ),
                                ),
                                settings: const RouteSettings(name: "review"),
                              ));
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

class ProductSize extends StatelessWidget {
  final String size;

  const ProductSize({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Container(
        width: (MediaQuery.sizeOf(context).width - 76) / 5,
        height: (MediaQuery.sizeOf(context).width - 76) / 5,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(245, 246, 250, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            size,
            style: AppTextStyle.s17_w6.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
