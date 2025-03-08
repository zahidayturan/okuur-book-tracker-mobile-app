import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/day_name_list.dart';

HomeController controller = Get.find();

Widget readsMonthlyInfo(List<OkuurBookAndLogInfo> logInfo,BuildContext context) {
  return logInfo.isNotEmpty ? ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: logInfo.length,
    itemBuilder: (context, index) {
      var currentLog = logInfo[index];
      var previousLog = index > 0 ? logInfo[index - 1] : null;

      DateTime currentDay = DateTime.parse(currentLog.okuurLogInfo.readingDate);

      bool showDate = previousLog == null || DateTime.parse(previousLog.okuurLogInfo.readingDate).day != DateTime.parse(currentLog.okuurLogInfo.readingDate).day;

      return Stack(
        children: [
          if (showDate)
          Container(
            width: 4,
            height: 60,
            margin: EdgeInsets.only(left: 3,top: index > 0 ? 20 : 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.onPrimaryContainer
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showDate)
                Padding(
                  padding: EdgeInsets.only(top: index > 0 ? 20 : 0),
                  child: Row(
                    children: [
                      Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Theme.of(context).colorScheme.secondaryContainer)),
                      const SizedBox(width: 4),
                      RegularText(
                        texts: '${currentDay.day} ${dayNames[currentDay.weekday-1]}',size: "l",weight: FontWeight.bold, color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RegularText(texts: currentLog.bookInfo.name),
                              const RegularText(texts: ' kitabından',size: "xs",family: "FontLight",)
                            ],
                          ),
                          RegularText(texts: '${currentLog.okuurLogInfo.numberOfPages} sayfa - ${currentLog.okuurLogInfo.timeRead} dakika',size: "s"),
                        ],
                      ),
                      RegularText(texts: '${currentDay.hour.toString().padLeft(2, '0')}:${currentDay.minute.toString().padLeft(2, '0')}',size: "s",),
                    ],
                  ),
                )
            ],
          ),
        ],
      );
    },
  ) : const Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: RegularText(texts: "Okuma bulunamadı"),
  );
}
