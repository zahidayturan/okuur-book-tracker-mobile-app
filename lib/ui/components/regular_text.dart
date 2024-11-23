import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  final String texts;
  final Color? color;
  final double? otherSize;
  final String? family;
  final int? maxLines;
  final FontStyle? style;
  final FontWeight? weight;
  final TextAlign? align;
  final String? size;

  const RegularText({
    required this.texts,
    this.color,
    this.otherSize,
    this.family,
    this.maxLines,
    this.style,
    this.weight,
    this.align,
    this.size,
    Key? key,
  }) : super(key: key);

  double? getSize(){
    if(otherSize != null){
      return otherSize;
    }
    if(size == "xxl"){
      return 18.0;
    }else if(size == "xl"){
      return 16.0;
    }else if(size == "l"){
      return 15.0;
    }else if(size == "m"){
      return 13.0;
    }else if(size == "s"){
      return 12.0;
    }else if(size == "xs"){
      return 11.0;
    }else{
      return 14.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      texts,
      style: TextStyle(
          color: color ?? Theme.of(context).colorScheme.secondary,
          fontFamily: family ?? "FontMedium",
          fontStyle: style,
          fontSize: getSize() ?? 14,
          fontWeight: weight
      ),
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
    );
  }
}