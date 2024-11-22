import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';

class PageHeaderTitle {

  AppColors colors = AppColors();

  final String title;
  final String subtitle;
  final String pathName;
  final bool? backButton;

  PageHeaderTitle({
    required this.title,
    required this.pathName,
    required this.subtitle,
    this.backButton,
  });



  Column getTitle(BuildContext context){
    Color colorTitle = Theme.of(context).colorScheme.primaryContainer;
    Color colorText = Theme.of(context).colorScheme.primaryContainer;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            backButton == true ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: popButton(context),
            ) : const SizedBox(),
            RegularText(texts: title,size: 18,color: colorTitle,family: "FontBold",maxLines: 3),
            const Spacer(),
            SizedBox(
                height: 26,
                child: Image.asset("assets/icons/$pathName.png",color: colorTitle,))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: RegularText(texts: subtitle,size: 12,color: colorText,family: "FontMedium",maxLines: 3),
        )
      ],
    );
  }

}
