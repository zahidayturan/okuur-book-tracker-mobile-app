import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/ui/components/page_switcher.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/shimmer_box.dart';
import 'package:okuur/ui/const/month_name_list.dart';

class WeeklyCalendar extends StatefulWidget {

  const WeeklyCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {

  AppColors colors = AppColors();
  HomeController controller = Get.find();
  @override
  void initState() {
    super.initState();
    controller.fetchLogForDate(false);
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      padding: const EdgeInsets.all(8),
      child: Obx(() => controller.logsLoading.value ? 
          const ShimmerBox(height: 150,borderRadius: BorderRadius.all(Radius.circular(8)))
          : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          weekdays(), //28
          const SizedBox(height: 8),
          dayInfo(controller.logForDate), //90
          const SizedBox(height: 8), //16
          RegularText(texts:controller.logForDate.isNotEmpty ? "Günlük Hedefe Ulaşıldı!" : "", color: Theme.of(context).colorScheme.inversePrimary, size:"m"),
        ],
      ),
      ),
    );
  }

  Widget weekdays(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dayContainer(),
        const SizedBox(width: 8),
        OkuurPageSwitcher(pageCount: controller.logForDate.length,currentPage: currentPage,)
      ],
    );
  }

  Widget dayContainer() {
    String dayInfo = "";
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
    }
    dayInfo = isSameDay(controller.initDate, DateTime.now()) ? "Bugün" : "${controller.initDate.year}";

    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: controller.initDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null && selectedDate != controller.initDate) {
          setState(() {
            controller.initDate = selectedDate;
            controller.fetchLogForDate(true);
          });
        }
      },
      onLongPress: () {
        setState(() {
          controller.initDate = DateTime.now();
          controller.fetchLogForDate(true);
        });
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 130),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: RichTextWidget(
              texts: ["${controller.initDate.day.toString()} ${months[controller.initDate.month]} ", dayInfo],
              colors: [Theme.of(context).colorScheme.secondary],
              fontFamilies: const ["FontBold", "FontMedium"],
              fontSize: 13,
              key: ValueKey<int>(controller.initDate.day),
              align: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  List<List<String>> infoList = [
    ["Bu ","haftanın en uzun okumasını"," yaptın."],
    ["Bu ","haftanın en iyi okumasını"," yaptın."]
  ];

  SizedBox dayInfo(List<OkuurHomeLogInfo> logForDate){
    return SizedBox(
      height: 90,
      child: logForDate.isEmpty
          ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(child: RegularText(texts: "Güne ait okuma\nbulunamadı",maxLines: 4)),
              Image.asset("assets/icons/calendar.png",color: Theme.of(context).scaffoldBackgroundColor,height: 64,),
            ],
          )
          : PageView.builder(
          itemCount: logForDate.length,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          itemBuilder: (context, index) {
            OkuurHomeLogInfo logInfo = logForDate[index];
            String points = (logInfo.okuurLogInfo.timeRead/
                (logInfo.okuurLogInfo.numberOfPages+1)
                    *logInfo.okuurLogInfo.numberOfPages).toStringAsFixed(0);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const RegularText(texts:"Okunan",otherSize: 10.0),
                RegularText(texts:logInfo.bookInfo.name, size:"m", family: "FontBold",maxLines: 2),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconAndText("assets/icons/page.png", "sayfa","${logInfo.okuurLogInfo.numberOfPages}"),
                    iconAndText("assets/icons/clock.png", "dakika","${logInfo.okuurLogInfo.timeRead}"),
                    iconAndText("assets/icons/point.png", "puan",points),
                  ],),
              ],
            );
          },
      ),
    );
  }
  
  Row iconAndText(String path,String text,String count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
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
            RegularText(texts:count, size: "m"),
            RegularText(texts:text,  size: "xs"),
          ],
        )
      ],
    );
  }

}