import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/slider_form.dart';

AppColors colors = AppColors();
final AddBookController controller = Get.find();
Obx addBookReadingTime(BuildContext context){
  return Obx(() => Visibility(
    visible: controller.bookCurrentStatus.value == 2,
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
          Row(
            children: [
              RichTextWidget(
                texts: const ["Kitap ","Değerlenirme Puanınız"],
                colors: [Theme.of(context).colorScheme.secondary],
                fontFamilies: const ["FontMedium","FontBold"],),
            ],
          ),
          const SizedBox(height: 4,),
          const RegularText(texts: "Kitaba 100 üzerinden bir puan verebilirsiniz.",size: "m",maxLines: 3),
          PageCountSelector(
            minValue: 0,maxValue: 100, currentValue: controller.bookRating.value,textController: controller.textControllerForSlider,onChanged: (int value) {
            controller.setBookRating(double.parse((value/20).toStringAsFixed(1)));
          },
          ),
        ],
      ),

    ),
  ));
}

