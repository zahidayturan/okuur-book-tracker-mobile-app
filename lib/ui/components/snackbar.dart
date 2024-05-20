import 'package:flutter/material.dart';

class SnackBarWidget {

  final BuildContext context;
  final Color backColor;
  final Widget textWidget;
  final int duration;

  SnackBarWidget({
    required this.context,
    required this.backColor,
    required this.textWidget,
    required this.duration
  });

  void showQuestionDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backColor,
        duration: Duration(seconds: duration),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: textWidget
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
