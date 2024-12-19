import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
AppColors colors = AppColors();
void showAlert(String title,String message){
  showDialog(
      context: Get.context!,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title,style: TextStyle(color: colors.red),textAlign: TextAlign.center,),
          content: Text(message,textAlign: TextAlign.center,),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 36,
                    decoration: BoxDecoration(
                      color: colors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                    ),
                    child: Center(child: RegularText(texts: "Tamam",color: colors.white))))
          ],
        );
      });
}