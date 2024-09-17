import 'package:flutter/material.dart';
import 'package:okuur/core/theme/theme_colors.dart';

@immutable
class AppTheme {
  static const colors = ThemeColors();

  const AppTheme._();


  static ThemeData lightTheme = ThemeData(
    primaryColor: colors.grey,
    useMaterial3: false,
    fontFamily: "FontMedium",
    scaffoldBackgroundColor: colors.backLight,
    colorScheme: const ColorScheme.light().copyWith(
        primary: colors.blue,
        secondary: colors.black,
        onPrimaryContainer: colors.white,
        onSecondary: colors.blue,
        inversePrimary: colors.blue,
        inverseSurface: colors.blueLight,
        primaryContainer: colors.greenDark,
        surface: colors.green,
        onBackground: colors.orange,
        onSurface: colors.green
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colors.white,
          unselectedItemColor: colors.greenDark,
          selectedItemColor: colors.grey
      ),
      buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.dark(
              primary: colors.blue,
              secondary: colors.blueLight
          )
      )
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: colors.black, //
    useMaterial3: false,
    fontFamily: "FontMedium",
    scaffoldBackgroundColor: colors.backDark,
    colorScheme: const ColorScheme.dark().copyWith(
        primary: colors.grey, //
        secondary: colors.grey,//
        onPrimaryContainer: colors.blackLight,//
        onSecondary: colors.black,//
        inversePrimary: colors.blueMid,//
        inverseSurface: colors.black,//
        primaryContainer: colors.grey,//
        surface: colors.grey,//
        onBackground: colors.black,//
        onSurface: colors.blueMid,//
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.black,
        unselectedItemColor: colors.grey,
        selectedItemColor: colors.blackLight
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.dark(
        primary: colors.greyMid,
        secondary: colors.blackLight
      )
    )
  );
}