import 'package:flutter/material.dart';
import 'package:okuur/ui/components/regular_text.dart';

class PageHeaderTitle {

  final Color textColor;
  final Color miniTextColor;
  final String iconName;

  PageHeaderTitle({
    required this.textColor,
    required this.miniTextColor,
    required this.iconName
  });

  Column getTitle(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text("İstatistiklerin",textColor,15,"FontBold",3),
            SizedBox(
                height: 20,
                child: Image.asset("assets/icons/$iconName.png",color: textColor,))
          ],
        ),
        text("Okumalarının analizini ve\ntakvimi görüntüle",miniTextColor,11,"FontMedium",3)
      ],
    );
  }
}
