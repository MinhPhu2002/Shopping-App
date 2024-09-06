import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/constants/image_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_cubit.dart';
import 'package:testapp/module/detail/description_product_screen.dart';
import 'package:testapp/utils/ui/mediaquery_extention.dart';

class ListProducts extends StatelessWidget {
  final int id;
  final String productImage;
  final String productName;
  final String productCost;

  const ListProducts(
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
        context.pushNamed('description', extra: id);
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
                    fit: BoxFit.fitHeight,
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
