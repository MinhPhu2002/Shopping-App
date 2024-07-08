import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 70,
      height: 15,
      child: RatingBar(
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
        onRatingChanged: (value) => debugPrint('$value'),
        initialRating: 4.2,
        maxRating: 5,
        size: 13,
        filledColor: const Color.fromRGBO(255, 152, 31, 1),
      ),
    );
  }
}
