import 'package:flutter/material.dart';

Widget bottomBar(){
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: SizedBox(
      height: 20,
      child: Image.asset("assets/logo/logo_text.png"),
    ),
  );
}