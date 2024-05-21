import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

Widget createForms(Widget formName){
  AppColors colors = AppColors();
  return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(4),
            bottomLeft: Radius.circular(4),
            topRight: Radius.circular(26),
            topLeft: Radius.circular(26)
        ),
        boxShadow: [
          BoxShadow(
            color: colors.greyDark.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: formName
  );
}