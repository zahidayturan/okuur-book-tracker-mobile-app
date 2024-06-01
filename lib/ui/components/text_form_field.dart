import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurTextFormField {

  final String label;
  final String hint;
  final TextEditingController? controller;
  final Key key;
  final void Function()? onTap;
  final bool? readOnly;

  OkuurTextFormField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.key,
    this.readOnly,
    this.onTap
  });

  Widget getTextFormFieldForPage(){
    AppColors colors = AppColors();
    return Center(
      child: Form(
        key: key,
        child: TextFormField(
          maxLines: 1,
          maxLength: 54,
          controller: controller,
          keyboardType: TextInputType.text,
          readOnly: readOnly != null ? readOnly! : false,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            labelText: label,
            errorStyle: TextStyle(height: 0),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
                color: colors.blue
            ),
            hintStyle: TextStyle(
              color: colors.black
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 2),
            border: InputBorder.none,
          ),
          onTap: onTap
        ),
      ),
    );
  }
}