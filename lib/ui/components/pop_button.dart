import 'package:flutter/material.dart';

Widget popButton(BuildContext context, [bool? result = false]) {
  return Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      shape: BoxShape.circle,
    ),
    child: Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, result);
        },
        borderRadius: BorderRadius.circular(50),
        child: Icon(
          Icons.arrow_back_rounded,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    ),
  );
}