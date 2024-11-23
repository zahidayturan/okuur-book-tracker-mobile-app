import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

AppColors colors = AppColors();

class BaseContainer extends StatelessWidget {

  final double? height;
  final Widget child;
  final Color? color;
  final double? radius;
  final double? padding;

  const BaseContainer({
    this.height,
    required this.child,
    this.color,
    this.radius,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(padding ?? 8),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
      ),
      child: child,
    );
  }
}
