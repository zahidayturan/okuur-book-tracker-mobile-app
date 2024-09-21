import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';

AppColors colors = AppColors();
final AddBookController controller = Get.find();

WillPopScope addLogAppBar(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      if (true != false) {
        bool shouldExit = await _showExitConfirmation(context);
        return shouldExit;
      } else {
        return true;
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("Okuma Kaydı Ekle", Theme.of(context).colorScheme.primaryContainer, 18, "FontBold", 3),
        InkWell(
          onTap: () async {
            if (true != false) {
              bool shouldExit = await _showExitConfirmation(context);
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

Future<bool> _showExitConfirmation(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: const Text(
        "Girdiğiniz bilgiler silinecektir.\nÇıkmak istiyor musunuz?",
        textAlign: TextAlign.center,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      actions: [
        Column(
          children: [
            getAlertButton("Geri Dön", false, false, context),
            const SizedBox(height: 8),
            getAlertButton("Çık", true, true, context),
          ],
        ),
      ],
    ),
  ) ??
      false;
}

InkWell getAlertButton(
    String text, bool isPop, bool fill, BuildContext context) {
  return InkWell(
    onTap: () => Navigator.of(context).pop(isPop),
    child: Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: fill ? colors.blue : null,
        border: fill ? null : Border.all(color: colors.blue, width: 1),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: fill ? colors.white : colors.blue,
          ),
        ),
      ),
    ),
  );
}