import 'package:flutter/material.dart';
import 'package:okuur/core/theme/theme_colors.dart';

@immutable
class AppTheme {
  static const colors = ThemeColors();

  const AppTheme._();


  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    useMaterial3: false,
    scaffoldBackgroundColor: colors.grey,
    colorScheme: const ColorScheme.light().copyWith(
        primary: colors.orange,
    )
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    useMaterial3: false,
    scaffoldBackgroundColor: colors.greenDark,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: colors.greenDark,
    ),
  );
}