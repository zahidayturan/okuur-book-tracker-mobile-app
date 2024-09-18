import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/slider_form.dart';
import 'package:okuur/ui/utils/validator.dart';


AppColors colors = AppColors();
final AddBookController controller = Get.find();
Obx addBookCurrentPage(BuildContext context){
  return Obx(() => Visibility(
    visible: controller.bookCurrentStatus.value == 1,
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
                  texts: ["Kaldığınız ","Sayfa"],
                  colors: [Theme.of(context).colorScheme.secondary],
                  fontFamilies: ["FontMedium","FontBold"],),
            ],
          ),
          const SizedBox(height: 4,),
          controller.bookPageCount.value == 0 ?
          Text("Kaldığınız sayfayı girebilmek için önce kitabın sayfa sayısını girmelisiniz",style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
              :
          OkuurValidator.rangeValidate(double.parse(controller.bookPageController.text),1,9999) == false ?
          Text("Kitabın sayfa sayısı 0'dan büyük ve 10000'den küçük olmalıdır",style: TextStyle(color: Theme.of(context).colorScheme.secondary))
              :
          PageCountSelector(
              minValue: 1,maxValue: controller.bookPageCount.value.toDouble()-1, currentValue: controller.bookCurrentPage.value.toDouble(),textController: controller.textControllerForSlider,onChanged: (int value) {
                controller.setBookCurrentPage(value);
          },
          ),
        ],
      ),

    ),
  ));
}

