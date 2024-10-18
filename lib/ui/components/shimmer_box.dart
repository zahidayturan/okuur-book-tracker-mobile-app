import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ShimmerBox({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.onPrimaryContainer,
      highlightColor: Theme.of(context).primaryColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
