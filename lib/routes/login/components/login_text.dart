import 'package:flutter/material.dart';

Text loginText(String text,Color color,double size, String family){
  return Text(
    text,style: TextStyle(
      color: color,
      fontFamily: family,
      fontSize: size
  ),
  );
}