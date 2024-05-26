import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurTextFormField {

  final String label;
  final String hint;
  final TextEditingController? controller;
  final Key key;

  OkuurTextFormField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.key
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Boş bırakılamaz';
            }
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            labelText: label,
            errorStyle: TextStyle(height: 0),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
                color: colors.blue
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 2),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}