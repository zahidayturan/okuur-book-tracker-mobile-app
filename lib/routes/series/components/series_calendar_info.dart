import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/shimmer_box.dart';
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
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(width:24,child: Icon(Icons.arrow_back_ios_rounded,color: colors.greyLight)),
            ),
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
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SizedBox(width:24,child: Icon(Icons.arrow_forward_ios_rounded,color: colors.greyLight)),
            ),
          ),
        ],
      ),
      Obx(() => controller.seriesCalendarLoading.value
          ? ShimmerBox(height: (6 * 40) + 48,borderRadius: BorderRadius.circular(8))
          : BaseContainer(
          child: Column(
            children: [
              SizedBox(
                height: 32,
                child: Center(
                  child: Row(
                    children: [
                      getDayText("Pzt"), getDayText("Sal"),
                      getDayText("Çar"), getDayText("Per"),
                      getDayText("Cum"), getDayText("Cmt"),
                      getDayText("Pzr")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 6 * 40,
                child: ListView.builder(
                  itemCount: controller.monthlySeriesInfo!.length,
                  itemBuilder: (context, weekIndex) {
                    int week = weekIndex + 1;
                    List<Map<String, dynamic>> weekDays = controller.monthlySeriesInfo![week]!;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SizedBox(
                        height: 36,
                        child: Row(
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
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getBoxColor(context, dayMap['series'], dayMap['isCur'], isCurrentDay),
                                  borderRadius: getRadius(dayMap['isFirst'],dayMap['isLast']),
                                ),
                                child: Center(
                                  child: RegularText(
                                    texts: dayText,
                                    color: getTextColor(context, dayMap['series'], dayMap['isCur'], isCurrentDay),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )))
    ],
  ));
}

Expanded getDayText(String text){
  return Expanded(child: Center(child: RegularText(texts: text,color: colors.greyLight)));
}

Color? getBoxColor(BuildContext context,bool isSeries, bool isCur, bool isToday){
  if(isSeries && isCur){
    return Theme.of(context).colorScheme.secondaryContainer;
  } else if(isToday){
    return Theme.of(context).scaffoldBackgroundColor;
  } else{
    return null;
  }
}

BorderRadius getRadius(bool isFirst, bool isLast){
  return BorderRadius.only(
    topLeft: Radius.circular(isFirst ? 50 : 0),
    topRight: Radius.circular(isLast ? 50 : 0),
    bottomLeft: Radius.circular(isFirst ? 50 : 0),
    bottomRight: Radius.circular(isLast ? 50 : 0),
  );
}

Color? getTextColor(BuildContext context,bool isSeries, bool isCur, bool isToday){
  if(isSeries && isCur){
    return colors.grey;
  } else if(isToday){
    return Theme.of(context).colorScheme.secondary;
  } else if(isSeries){
    return Theme.of(context).colorScheme.secondaryContainer;
  } else{
    return colors.greyLight;
  }
}