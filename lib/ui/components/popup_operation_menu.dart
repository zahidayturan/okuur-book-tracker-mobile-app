import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showOkuurPopupMenu(
    Offset offset,
    Color backColor,
    double marginRight,
    List<PopupMenuEntry<int>> items,
    Future<void> Function(int?) func
    ) {
  double left = offset.dx;
  double top = offset.dy;
  showMenu<int>(
    context: Get.context!,
    color: backColor,
    position: RelativeRect.fromLTRB(left, top + 8, marginRight, 0),
    items: items,
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      side: BorderSide(color: Theme.of(Get.context!).primaryColor, width: 1),
    ),
  ).then((value) {
    if (value != null) {
      func(value);
    }
  });
}
