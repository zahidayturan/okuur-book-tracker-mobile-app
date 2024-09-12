import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/slider_form.dart';
import 'package:okuur/ui/utils/validator.dart';


AppColors colors = AppColors();
final AddBookController controller = Get.find();
Obx addBookCurrentPage(){
  return Obx(() => Visibility(
    visible: controller.bookCurrentStatus.value == 1,
    child: Container(
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
              texts: ["Kaldığınız ","Sayfa"],
              colors: [colors.black,colors.black],
              fontFamilies: ["FontMedium","FontBold"],
              fontSize: 15,
              align: TextAlign.start),
          controller.bookPageCount.value == 0 ?
          const Text("Kaldığınız sayfayı girebilmek için önce kitabın sayfa sayısını girmelisiniz")
              :
          OkuurValidator.rangeValidate(double.parse(controller.bookPageController.text),1,9999) == false ?
          const Text("Kitabın sayfa sayısı 0'dan büyük ve 10000'den küçük olmalıdır")
              :
          PageCountSelector(
              minValue: 1,maxValue: controller.bookPageCount.value.toDouble(), currentValue: controller.bookCurrentPage.value.toDouble(),textController: controller.textControllerForSlider,onChanged: (int value) {
                controller.setBookCurrentPage(value);
          },
          ),
        ],
      ),

    ),
  ));
}

