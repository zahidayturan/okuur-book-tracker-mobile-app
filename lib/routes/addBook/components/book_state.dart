import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

import '../../../ui/components/selectable_question.dart';

AppColors colors = AppColors();
Container addBookState(){
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
            texts: ["Kitabın ","İlerleme Durumunu ","Seçiniz"],
            colors: [colors.black,colors.black,colors.black],
            fontFamilies: ["FontMedium","FontBold","FontMedium"],
            fontSize: 15,
            align: TextAlign.start),
        OkuurSelectableQuestion(optionCount: 3,onChanged: (value) {
        },options: ["Kitaba daha başlamadım","Kitaptan biraz okudum","Kitabın hepsini okudum"]),
      ],
    ),

  );
}