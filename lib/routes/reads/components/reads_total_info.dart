import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';

HomeController controller = Get.find();

Widget readsTotalInfo(BuildContext context,Map<String, dynamic> data){
  return BaseContainer(
    radius: 8,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconAndText(context,"assets/icons/page.png", "sayfa","${data["page"]}"),
          iconAndText(context,"assets/icons/clock.png", "dakika","${data["time"]}"),
          iconAndText(context,"assets/icons/point.png", "puan","${data["point"]}"),
        ],),
    ),
  );
}


Row iconAndText(BuildContext context,String path,String text,String count){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor
        ),
        padding: const EdgeInsets.all(5),
        child: Image.asset(path,color: Theme.of(context).colorScheme.secondary,),
      ),
      const SizedBox(width: 4,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegularText(texts:count, color: Theme.of(context).colorScheme.secondary, size: "m"),
          RegularText(texts:text, color: Theme.of(context).colorScheme.secondary, size: "xs"),
        ],
      )
    ],
  );
}
