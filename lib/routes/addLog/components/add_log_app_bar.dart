import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';

AppColors colors = AppColors();
final AddLogController controller = Get.find();

WillPopScope addLogAppBar(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      if (!controller.checkAllInfoIsNull()) {
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
        RegularText(texts: "Okuma Kaydı Ekle",color: Theme.of(context).colorScheme.primaryContainer,size: "xxl",family: "FontBold",maxLines: 3),
        InkWell(
          onTap: () async {
            if (!controller.checkAllInfoIsNull()) {
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
      content: const RegularText(
        texts: "Girdiğiniz bilgiler silinecektir.\nÇıkmak istiyor musunuz?",
        align: TextAlign.center,
        size: "l",
        maxLines: 5,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      actions: [
        Row(
          children: [
            getAlertButton("Geri Dön", false, false, context),
            const SizedBox(width: 8),
            getAlertButton("Çık", true, true, context),
          ],
        ),
      ],
    ),
  ) ??
      false;
}

Expanded getAlertButton(
    String text, bool isPop, bool fill, BuildContext context) {
  return Expanded(
    child: InkWell(
      onTap: () => Navigator.of(context).pop(isPop),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: fill ? colors.blue : null,
          border: fill ? null : Border.all(color: colors.blue, width: 1),
        ),
        child: Center(
          child: RegularText(
            texts: text,
            color: fill ? colors.white : colors.blue,
            maxLines: 5,
          ),
        ),
      ),
    ),
  );
}