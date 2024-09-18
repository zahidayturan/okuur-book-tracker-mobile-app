import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/date_picker.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/slider_form.dart';
import 'package:okuur/ui/utils/validator.dart';


AppColors colors = AppColors();
final AddBookController controller = Get.find();
Obx addBookFinishDate(BuildContext context){
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
                texts: ["Kitap ","Başlama ve Bitirme"," Tarihi"],
                colors: [Theme.of(context).colorScheme.secondary],
                fontFamilies: ["FontMedium","FontBold","FontMedium"],),
            ],
          ),
          const SizedBox(height: 4,),
          Text("Kitabı okuduğunuz tarih aralığını seçiniz",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            OkuurDateTimePicker(
              formKey: controller.bookStartedDateKey,
              controller: controller.bookStartedDateController,
              endController: controller.bookFinishedDateController,
              formEndKey: controller.bookFinishedDateKey,
              label: "Başlangıç",
              isRangePicker: true,
              initialDate: DateTime.now().subtract(Duration(days: 7)),
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now(),
            )
          ],)
        ],
      ),

    ),
  ));
}

