import 'package:flutter/material.dart';

ClipRRect imageShower(String link){
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(6)),
    child: link != "none" ? Image.network(
      link,
      fit: BoxFit.cover,
    ) : Image.asset("assets/logo/book_logo.png",fit: BoxFit.cover),
  );
}