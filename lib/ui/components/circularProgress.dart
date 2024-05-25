import 'package:flutter/material.dart';

class GetProgressIndicator {

  Center getCircular(double size,Color color){
    Widget circularIndicator = CircularProgressIndicator(
      color: color,
    );
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: circularIndicator,
      ),
    );
  }
}
