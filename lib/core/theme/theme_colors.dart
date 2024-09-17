import 'package:flutter/material.dart';

@immutable
class ThemeColors{
  final greenDark =  const Color(0xFF10403B);
  final green =  const Color(0xFF127369);
  final blue = const Color(0xFF038C8C);
  final blueLight = const Color(0xFF8AA6A3);
  final blueMid = const Color(0XFF00B0B0);
  final greyDark = const Color(0xFF4C5958);
  final greyMid = const Color(0xFF606060);
  final grey = const Color(0xFFF5F5F5);
  final white = const Color(0xFFFFFFFF);
  final orange = const Color(0xFFF24405);
  final red = const Color(0xFFD93250);
  final yellow = const Color(0xFFF2B705);
  final lemon = const Color(0xFFAFBF36);
  final black = const Color(0xFF0E0E0E);
  final blackLight = const Color(0XFF222222);

  const ThemeColors();

  Color get backLight => grey;
  Color get backDark => black;
}