import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';
import '../../../ui/components/selectable_question.dart';

AppColors colors = AppColors();
final AddBookController controller = Get.find();
Container addBookState(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichTextWidget(
            texts: const ["Kitabın ","İlerleme Durumunu ","Seçiniz"],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: const ["FontMedium","FontBold","FontMedium"],),
        OkuurSelectableQuestion(
            optionCount: 3,
            currentOption: controller.bookCurrentStatus.toInt(),
            onChanged: (value) {
              controller.setBookCurrentStatus(value);
            },
            options: const ["Kitaba daha başlamadım","Kitaptan biraz okudum","Kitabın hepsini okudum"]),
      ],
    ),

  );
}