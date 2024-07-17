import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';

class SettingRow {

  AppColors colors = AppColors();

  final Color color;
  final String title;
  final Widget widget;

  SettingRow({
    required this.color,
    required this.title,
    required this.widget
  });


  Container getSettingRow(){
    return Container(
      decoration: BoxDecoration(
          color: colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text(title,color,13,"FontMedium",1),
          widget
        ],
      ),
    );
  }
}
