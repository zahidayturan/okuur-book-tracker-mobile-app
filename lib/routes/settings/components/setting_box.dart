import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';

class SettingBox {

  AppColors colors = AppColors();

  final Color color;
  final String title;
  final Widget widget;

  SettingBox({
    required this.color,
    required this.title,
    required this.widget
  });


  Container getSettingBox(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegularText(texts: title,size: 15,color: color,family: "FontBold",maxLines: 1),
              /*SizedBox(
                  height: 18,
                  child: Image.asset("assets/icons/star.png",color: color,))*/
            ],
          ),
          widget
        ],
      ),
    );
  }
}
