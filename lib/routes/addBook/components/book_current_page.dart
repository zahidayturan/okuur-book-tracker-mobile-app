import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/slider_form.dart';


AppColors colors = AppColors();
Container addBookCurrentPage(){
  return Container(
    decoration: BoxDecoration(
      color: colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichTextWidget(
            texts: ["Kaldığınız ","Sayfa"],
            colors: [colors.black,colors.black],
            fontFamilies: ["FontMedium","FontBold"],
            fontSize: 15,
            align: TextAlign.start),
        PageCountSelector(minValue: 1,maxValue: 50),
      ],
    ),

  );
}