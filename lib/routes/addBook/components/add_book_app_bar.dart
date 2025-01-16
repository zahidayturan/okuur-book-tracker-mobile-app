import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/functional_alert_dialog.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/book_type_list.dart';

AppColors colors = AppColors();
final AddBookController controller = Get.find();

WillPopScope addBookAppBar(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      if (controller.bookNameController.text.isNotEmpty ||
          controller.bookAuthorController.text.isNotEmpty ||
          controller.bookPageController.text.isNotEmpty ||
          controller.bookTypeController.text != bookTypeList.first) {
        bool shouldExit = await _showCustomDialog(context);
        return shouldExit;
      } else {
        return true;
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegularText(texts: "Yeni Kitap Ekle",color: Theme.of(context).colorScheme.primaryContainer,size: "xxl",family: "FontBold",maxLines: 3),
        InkWell(
          onTap: () async {
            if (controller.bookNameController.text.isNotEmpty ||
                controller.bookAuthorController.text.isNotEmpty ||
                controller.bookPageController.text.isNotEmpty ||
                controller.bookTypeController.text != bookTypeList.first) {
              bool shouldExit = await _showCustomDialog(context);
              if (shouldExit) {
                Get.back();
              }
            } else {
              Get.back();
            }
          },
          highlightColor: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Container(
            height: 32,
            width: 32,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/icons/close.png",
              color: colors.grey,
            ),
          ),
        ),
      ],
    ),
  );
}

Future<bool> _showCustomDialog(BuildContext context) async {
  bool? result = await OkuurAlertDialog.show(
    context: context,
    contentText: "Girdiğiniz bilgiler silinecektir.\nÇıkmak istiyor musunuz?",
    buttons: [
      AlertButton(text: "Geri Dön", fill: false, returnValue: false),
      AlertButton(text: "Çık", fill: true, returnValue: true),
    ],
  );
  return result ?? false;
}