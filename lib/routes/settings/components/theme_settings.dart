import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class ThemeSettings extends StatefulWidget {

  const ThemeSettings({
    super.key,
  });

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  AppColors colors = AppColors();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}