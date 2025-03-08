import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/circular_progress.dart';
import 'package:okuur/ui/components/regular_text.dart';

AppColors colors = AppColors();
class LoadingDialog {
  static Future<void> showLoading({String? message}) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 90),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetProgressIndicator().getCircular(44, Theme.of(context).colorScheme.inversePrimary),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    RegularText(
                      texts: message,
                      color: Theme.of(context).colorScheme.secondary, size: "xl",
                      align: TextAlign.center,
                      maxLines: 6,
                    ),
                  ],
                  const SizedBox(height: 16),
                  RegularText(
                    texts: "Lütfen bekleyin...",
                    color: Theme.of(context).colorScheme.primary,
                    align: TextAlign.center,
                    size: "s",
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> hideLoading() async {
    Navigator.of(Get.context!, rootNavigator: true).pop();
  }
}
