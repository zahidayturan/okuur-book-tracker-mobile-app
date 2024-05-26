import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

Widget getTextFormFieldForPage(){
  AppColors colors = AppColors();
  return Container(
    child: Center(
      child: Form(
        //key: key,
        child: TextFormField(
          maxLines: 1,
          maxLength: 54,
          //controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Boş bırakılamaz';
            }
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Adını yazınız",
            counterText: "",
            labelText: "Kitabın Adı",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              color: colors.blue
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 2),
            border: InputBorder.none,
          ),
        ),
      ),
    ),
  );
}