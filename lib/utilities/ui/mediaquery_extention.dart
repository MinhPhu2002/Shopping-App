import 'package:flutter/cupertino.dart';

extension MediaqueryExtention on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  Size getResponSizeBasOnWidth(
      {required double designWidth,
      required double designHeight,
      double designScreenWidth = 375,
      double designScreenHeight = 812}) {
    double screenWidth = size.width;
    double width = designWidth * screenWidth / designScreenWidth;
    double height = designHeight * screenWidth / designScreenWidth;
    Size wh = Size(width, height);
    return wh;
  }

  Size getWidth(
      {required double designWidth,
      double designScreenWidth = 375,
      double designScreenHeight = 812}) {
    double screenWidth = size.width;
    double width = designWidth * screenWidth / designScreenWidth;
    double height = width * designScreenHeight / designWidth;
    Size w = Size(width, height);
    return w;
  }
}
