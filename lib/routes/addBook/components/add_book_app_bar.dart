import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
AppColors colors = AppColors();
Row addBookAppBar(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      text("Yeni Kitap Ekle",colors.greenDark,18,"FontBold",3),
      InkWell(
        onTap: () {
          Get.back();
        },
        highlightColor: colors.greenDark,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Container(
            height: 32,
            width: 32,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.greenDark,
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/icons/close.png",color: colors.white,)
        ),
      ),
    ],
  );
}