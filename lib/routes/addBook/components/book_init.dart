import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

import '../../../ui/components/selectable_question.dart';

AppColors colors = AppColors();
final AddBookController controller = Get.find();
Obx addBookInit(BuildContext context){
  return Obx(() => Visibility(
    visible: controller.bookCurrentStatus.value != 2,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
              texts: ["Kitabın ","İlk Durumu ","Ne Olsun"],
              colors: [Theme.of(context).colorScheme.secondary],
              fontFamilies: ["FontMedium","FontBold","FontMedium"],
              fontSize: 15,
              align: TextAlign.start),
          OkuurSelectableQuestion(optionCount: 2,currentOption: controller.bookInit.toInt(),onChanged: (value) {
            controller.setBookInit(value);
          },options: controller.bookCurrentStatus == 0 ?
          ["Kitabı okumaya hemen başlayacağım","Kitaba daha sonra başlayacağım"] :
          ["Kitabı okumaya devam edeceğim","Kitaba daha sonra devam edeceğim"]
          ),
        ],
      ),

    ),
  ));
}