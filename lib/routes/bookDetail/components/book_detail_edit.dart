import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/text_form_field.dart';

AppColors colors = AppColors();
BookDetailController controller = Get.find();


void showBookDetailEditDialog(BuildContext context,OkuurBookInfo okuurBookInfo) {


  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  popButton(context,false),
                  const RegularText(texts: "Kitap Bilgilerini Düzenle",size: "xl",)
                ],
              ),
              const SizedBox(height: 12),
              form(context, "Kitabın Adı", "Adını yazınız",
                  controller.bookNameController.text.isNotEmpty,
                  controller.bookNameController, controller.bookNameKey,
                  (name) {
                    controller.editChangeDetect();
                  },
                  TextInputType.text),
              const SizedBox(height: 12,),
              addButton(context)
            ],
          ),
        ),
      );},
  );
}

Widget form(BuildContext context,String label,String hint,validate,controller,key,void Function(String)? onFieldSubmitted,keyboardType) {
  return OkuurTextFormField(
      hint: hint,
      controller: controller,
      key: key,
      label: label,
      labelColor: validate == true ? colors.blue : colors.red,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted
  ).getTextFormFieldForPage(context);
}

Widget addButton(BuildContext context) {
  return Obx(() => Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            if(controller.isAllChanged.value){
              Navigator.of(context).pop();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: controller.isAllChanged.value ? Theme.of(context).colorScheme.onPrimaryContainer :colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RegularText(
                    texts: controller.isAllChanged.value ? "Değişiklikleri Kaydet" : "Bilgileri Düzenleyin",
                    color: controller.isAllChanged.value ? Theme.of(context).colorScheme.secondary : colors.greyMid,size: "l"),
              ),
            ),
          ),
        ),
      ),
    ],
  ));
}


