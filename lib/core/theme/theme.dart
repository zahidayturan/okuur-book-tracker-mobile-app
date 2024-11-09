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
        onSurface: colors.green,
        tertiary: colors.greenDark,
        tertiaryContainer: colors.greenDark,
        onTertiary: colors.grey,
        secondaryContainer: colors.orange
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
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.blue,
          foregroundColor: colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      shadowColor: Colors.grey
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
        tertiary: colors.blue,//
        tertiaryContainer: colors.blackLight,//
        onTertiary: colors.greyMid,//
        secondaryContainer: colors.blue,//
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
    ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.blue,
          foregroundColor: colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    shadowColor: colors.black
  );
}