import 'package:flutter/material.dart';
import 'package:okuur/ui/components/circular_progress.dart';

class LoadingDialog {
  static Future<void> showLoading(BuildContext context, {String? message}) async {
    return showDialog<void>(
      context: context,
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
                  SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> hideLoading(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
