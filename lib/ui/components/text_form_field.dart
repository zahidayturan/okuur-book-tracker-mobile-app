import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:flutter/services.dart';

class OkuurTextFormField {
  final String? label;
  final Color? labelColor;
  final String hint;
  final TextEditingController? controller;
  final Key key;
  final void Function()? onTap;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  OkuurTextFormField({
    this.label,
    this.labelColor,
    required this.hint,
    required this.controller,
    required this.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.keyboardType,
    this.onTap,
  });

  Widget getTextFormFieldForPage(BuildContext context) {
    AppColors colors = AppColors();
    return Center(
      child: Form(
        key: key,
        child: TextFormField(
          maxLines: 1,
          maxLength: 54,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          readOnly: readOnly ?? false,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
            inputFormatters: keyboardType == TextInputType.number ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ] : null,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            labelText: label,
            errorStyle: const TextStyle(height: 0),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
                color: labelColor ?? colors.blue
            ),
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14
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
