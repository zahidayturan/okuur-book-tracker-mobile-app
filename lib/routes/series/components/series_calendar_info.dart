import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/month_name_list.dart';

HomeController controller = Get.find();

Widget seriesCalendarInfo(){
  return BaseContainer(child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              controller.decrementMonth();

            },
            child: const SizedBox(height:24,width:24,child: Icon(Icons.arrow_back_ios_rounded)),
          ),
          Obx(() => InkWell(
            onLongPress: () {
              controller.resetMonth();
            },
            child: RegularText(
              texts: "${months[controller.seriesMonth.value.month]} ${controller.seriesMonth.value.year}",
              size: "xl", weight: FontWeight.bold,
            ),
          )),
          InkWell(
            onTap: () {
              controller.incrementMonth();
            },
            child: const SizedBox(height:24,width:24,child: Icon(Icons.arrow_forward_ios_rounded)),
          ),
        ],
      ),
      BaseContainer(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Center(child: RegularText(texts: "Pzt",color: colors.greyLight))),
                  Expanded(child: Center(child: RegularText(texts: "Sal",color: colors.greyLight))),
                  Expanded(child: Center(child: RegularText(texts: "Çar",color: colors.greyLight))),
                  Expanded(child: Center(child: RegularText(texts: "Per",color: colors.greyLight))),
                  Expanded(child: Center(child: RegularText(texts: "Cum",color: colors.greyLight))),
                  Expanded(child: Center(child: RegularText(texts: "Cmt",color: colors.greyLight))),
                  Expanded(child: Center(child: RegularText(texts: "Pzr",color: colors.greyLight)))
                ],
              ),
              Obx(() => SizedBox(
                height: 220,
                child: ListView.builder(
                  itemCount: controller.getDaysInMonth().keys.length,
                  itemBuilder: (context, weekIndex) {
                    int week = weekIndex + 1;
                    List<Map<String, dynamic>> weekDays = controller.getDaysInMonth()[week]!;
                    return Row(
                      children: weekDays.asMap().entries.map((entry) {
                        Map<String, dynamic> dayMap = entry.value;


                        String dayText = '';
                        bool isCurrentDay = false;
                        if (dayMap['date'] != null) {
                          dayText = DateFormat('d').format(dayMap['date']);

                          if(dayMap['series'] != true){
                            DateTime currentDate = DateTime.now();
                            DateTime currentDayOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
                            DateTime mapDate = dayMap['date'];
                            DateTime mapDayOnly = DateTime(mapDate.year, mapDate.month, mapDate.day);
                            isCurrentDay = currentDayOnly.isAtSameMomentAs(mapDayOnly);
                          }

                        }

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                              height: 28,
                              decoration: BoxDecoration(
                                color: dayMap['series'] == true
                                    ? Theme.of(context).colorScheme.secondaryContainer
                                    : isCurrentDay ? Theme.of(context).scaffoldBackgroundColor : null,
                                borderRadius: BorderRadius.only(
                                  topLeft: dayMap['isFirst'] == true ? const Radius.circular(50) : Radius.zero,
                                  topRight: dayMap['isLast'] == true ? const Radius.circular(50) : Radius.zero,
                                  bottomLeft: dayMap['isFirst'] == true ? const Radius.circular(50) : Radius.zero,
                                  bottomRight: dayMap['isLast'] == true ? const Radius.circular(50) : Radius.zero,
                                ),
                              ),
                              child: Center(
                                child: RegularText(
                                  texts: dayText,
                                  color: dayMap['series'] == true ? colors.grey : colors.greyLight,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              )),

            ],
          ))
    ],
  ));
}