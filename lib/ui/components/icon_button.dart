import 'package:flutter/material.dart';

InkWell iconButton(String path,Color color,BuildContext context){
  return InkWell(
    onTap: () {
      Navigator.of(context).pop();
    },
    highlightColor: color,
    borderRadius: BorderRadius.all(Radius.circular(1)),
    child: Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path),
      ),
    ),
  );
}