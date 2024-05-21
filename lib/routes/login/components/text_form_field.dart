import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

Widget getTextFormField(TextEditingController? controller,String hintText,int maxLength,String helperText,Key key,String errorText,bool passwordVisible){
  AppColors colors = AppColors();
  return Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
        color: colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(10))
    ),
    child: Center(
      child: Form(
        key: key,
        child: TextFormField(
          maxLines: 1,
          maxLength: maxLength,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Boş bırakılamaz';
            }
          },
          obscureText: passwordVisible ? true : false,
          style: TextStyle(color: colors.greenDark),
          keyboardType: TextInputType.text,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            hintStyle: TextStyle(
                color: colors.greenDark,
                fontSize: 14,
                height: 1,
                fontFamily: "FontMedium"
            ),
            errorStyle: TextStyle(
                color: colors.red,
                fontSize: 12,
                height: 1,
                fontFamily: "FontMedium"
            ),
            counterText: "",
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
        ),
      ),
    ),
  );
}