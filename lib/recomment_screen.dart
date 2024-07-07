import 'package:flutter/material.dart';
import 'package:testapp/core/constaints/image_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/home_screen.dart';

class RecommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ColoredBox(
      color: const Color.fromRGBO(151, 117, 250, 1),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(151, 117, 250, 1),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.recommentScreenIllustrator,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                child: Container(
                  height: 244,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Look Good, Feel Good",
                        style:
                            AppTextStyle.s25_w6.copyWith(color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 26),
                        child: Text(
                          " Create your individual & unique style and look amazing everyday.",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s15_w4.copyWith(
                              color: Color.fromRGBO(143, 149, 158, 1)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: (MediaQuery.sizeOf(context).width - 70) / 2,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(245, 246, 250, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Women",
                                style: AppTextStyle.s17_w5.copyWith(
                                    color: Color.fromRGBO(143, 149, 158, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 60,
                            width: (MediaQuery.sizeOf(context).width - 70) / 2,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(151, 117, 250, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Men",
                                style: AppTextStyle.s17_w5.copyWith(
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                                settings: const RouteSettings(name: "Home")),
                            (route) {
                              return false;
                            },
                          );
                        },
                        child: Text(
                          "Skip",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s17_w5.copyWith(
                              color: Color.fromRGBO(143, 149, 158, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
