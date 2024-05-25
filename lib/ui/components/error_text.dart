import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

class ErrorText {
  AppColors colors = AppColors();

  RichTextWidget userDataNotFound(){
    return RichTextWidget(
        texts: ["Kullanıcı bilgisi ","bulunamadı!"],
        colors: [colors.green,colors.greenDark],
        fontFamilies: ["FontMedium","FontBold"],
        fontSize: 13,
        align: TextAlign.center);
  }

  RichTextWidget error(){
    return RichTextWidget(
        texts: ["Bir ","hata ","oluştu!"],
        colors: [colors.green,colors.greenDark,colors.green],
        fontFamilies: ["FontMedium","FontBold","FontMedium"],
        fontSize: 13,
        align: TextAlign.center);
  }
}
