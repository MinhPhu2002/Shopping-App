import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/core/theme/app_text_style.dart';

class Brand extends StatelessWidget {
  final String nameBrand;
  final String slug;

  const Brand({super.key, required this.nameBrand, required this.slug});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          context.pushNamed('brand',
              extra: {'nameBrand': nameBrand, 'slug': slug});
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
