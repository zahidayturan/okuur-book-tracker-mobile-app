import 'package:flutter/material.dart';

Text text(String text,Color color,double size, String family,int maxLines){
  return Text(
    text,style: TextStyle(
      color: color,
      fontFamily: family,
      fontSize: size
  ),overflow: TextOverflow.ellipsis,maxLines: maxLines,
  );
}