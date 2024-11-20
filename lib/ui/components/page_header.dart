import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';
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
            backButton == true ? backButtonWidget(context) : const SizedBox(),
            text(title,colorTitle,18,"FontBold",3),
            const Spacer(),
            SizedBox(
                height: 26,
                child: Image.asset("assets/icons/$pathName.png",color: colorTitle,))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: text(subtitle,colorText,12,"FontMedium",3),
        )
      ],
    );
  }

  Widget backButtonWidget(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          Get.back();
        },
        highlightColor: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Container(
          height: 28,
          width: 28,
          padding: const EdgeInsets.all(4),

          child: Image.asset("assets/icons/back_arrow.png",color: Theme.of(context).colorScheme.secondary,)
        ),
      ),
    );
  }
}
