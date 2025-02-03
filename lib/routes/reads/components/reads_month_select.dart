import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/month_name_list.dart';

HomeController controller = Get.find();

Widget readsMonthSelect(){
  return BaseContainer(
      child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                controller.readsDecrementMonth();
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: SizedBox(width:24,child: Icon(Icons.arrow_back_ios_rounded)),
              ),
            ),
            Obx(() => InkWell(
              onLongPress: () {
                controller.readsResetMonth();
              },
              child: RegularText(
                texts: "${months[controller.readsMonth.value.month]} ${controller.readsMonth.value.year}",
                size: "xl", weight: FontWeight.bold,
              ),
            )),
            InkWell(
              onTap: () {
                controller.readsIncrementMonth();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: SizedBox(width:24,child: Icon(Icons.arrow_forward_ios_rounded)),
              ),
            ),
          ],
        ),
      )
    ],
  ));
}
