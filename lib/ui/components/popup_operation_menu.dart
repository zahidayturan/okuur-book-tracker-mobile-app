import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';

AppColors colors = AppColors();
void showOkuurPopupMenu(Offset offset, Color backColor, double marginRight, List<PopupMenuEntry<int>> items){
  double left = offset.dx;
  double top = offset.dy;
  showMenu(
    context: Get.context!,
    color: backColor,
    position: RelativeRect.fromLTRB(left, top+8, marginRight, 0),
    items: items,
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      side: BorderSide(color: Theme.of(Get.context!).primaryColor,width: 1)
    ),
  );
}