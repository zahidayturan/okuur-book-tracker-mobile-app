import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAlert(String title,String message){
  showDialog(
      context: Get.context!,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"))
          ],
        );
      });
}