import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/screens/add_books.dart';
import 'package:okuur/ui/screens/internet_connection.dart';

class PageHeaderTitle {

  AppColors colors = AppColors();

  final String title;
  final String subtitle;
  final String pathName;
  final bool? otherWidget;

  PageHeaderTitle({
    required this.title,
    required this.pathName,
    required this.subtitle,
    this.otherWidget,
  });



  Column getTitle(){
    Color colorTitle = colors.greenDark;
    Color colorText = colors.greenDark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(title,colorTitle,18,"FontBold",3),
            Spacer(),
            otherWidget == true ? addBookButton() : SizedBox(),
            SizedBox(
                height: 26,
                child: Image.asset("assets/icons/$pathName.png",color: colorTitle,))
          ],
        ),
        text(subtitle,colorText,12,"FontMedium",3)
      ],
    );
  }

  Widget addBookButton(){
    return InkWell(
      onTap: () {
        Navigator.push(
          Get.context!,
          PageRouteBuilder(
            opaque: false,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, animation, nextanim) => const AddBookPage(),
            reverseTransitionDuration: const Duration(milliseconds: 1),
            transitionsBuilder: (context, animation, nexttanim, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      highlightColor: colors.orange,
      borderRadius: BorderRadius.all(Radius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          decoration: BoxDecoration(
            color: colors.orange,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15),topRight: Radius.circular(2),topLeft: Radius.circular(2))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
            child: RichTextWidget(
                texts: ["+ Kitap ","Ekle"],
                colors: [colors.white,colors.white],
                fontFamilies: ["FontMedium","FontBold"],
                fontSize: 15,
                align: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
