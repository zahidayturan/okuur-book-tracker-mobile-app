import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/ui/components/circular_progress.dart';
import 'package:okuur/ui/components/regular_text.dart';

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
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GetProgressIndicator().getCircular(44, Theme.of(context).colorScheme.inversePrimary),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  RegularText(
                    texts: message,
                    color: Colors.white, size: "xl",
                    align: TextAlign.center,
                  ),
                ],
              ],
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
