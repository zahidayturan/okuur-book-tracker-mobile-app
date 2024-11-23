import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';

AppColors colors = AppColors();

class TextIconButton extends StatelessWidget {

  final double? height;
  final String text;
  final Color? backColor;
  final double? radius;
  final double? padding;
  final IconData icon;
  final Color? iconColor;

  const TextIconButton({
    this.height,
    required this.text,
    this.backColor,
    this.radius,
    this.padding,
    required this.icon,
    this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 50)),
      ),
      child: Row(
        children: [
          Icon(icon,size: 16,color: iconColor ?? Theme.of(context).colorScheme.secondary,),
          const SizedBox(width: 8),
          RegularText(texts: text,color: iconColor,size: "m")
        ],
      ),
    );
  }
}
