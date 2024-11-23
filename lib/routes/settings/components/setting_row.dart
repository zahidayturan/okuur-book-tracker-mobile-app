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


  Container getSettingRow(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RegularText(texts: title,size: "m",color: color),
          widget
        ],
      ),
    );
  }
}
