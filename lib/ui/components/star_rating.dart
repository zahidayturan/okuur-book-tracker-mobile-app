import 'package:flutter/material.dart';
import 'package:okuur/ui/components/regular_text.dart';

class OkuurStarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final Color filledStarColor;
  final Color unfilledStarColor;
  final double starSize;
  final String text;
  final bool vertical;

  const OkuurStarRating({
    Key? key,
    this.rating = 0,
    this.starCount = 5,
    this.filledStarColor = Colors.amber,
    this.unfilledStarColor = Colors.grey,
    this.starSize = 17.0,
    this.text = "0",
    this.vertical = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return vertical
        ? Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(starCount, (index) {
            if (index < rating.floor()) {
              return Icon(
                Icons.star_rate_rounded,
                color: filledStarColor,
                size: starSize,
              );
            } else if (index < rating && rating % 1 != 0) {
              return Icon(
                Icons.star_half_rounded,
                color: filledStarColor,
                size: starSize,
              );
            } else {
              return Icon(
                Icons.star_border_rounded,
                color: unfilledStarColor,
                size: starSize,
              );
            }
          }),
        ),
        Visibility(
          visible: text != "",
          child: RegularText(
            texts: text,
            color: filledStarColor,
            size: starSize > 17 ? "l" : "xs",
          ),
        ),
      ],
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        if (index < rating.floor()) {
          return Icon(
            Icons.star_rate_rounded,
            color: filledStarColor,
            size: starSize,
          );
        } else if (index < rating && rating % 1 != 0) {
          return Icon(
            Icons.star_half_rounded,
            color: filledStarColor,
            size: starSize,
          );
        } else {
          return Icon(
            Icons.star_border_rounded,
            color: unfilledStarColor,
            size: starSize,
          );
        }
      })..add(
        Visibility(
          visible: text != "",
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RegularText(
              texts: text,
              color: filledStarColor,
              size: starSize > 17 ? "l" : "xs",
            ),
          ),
        ),
      ),
    );
  }
}
