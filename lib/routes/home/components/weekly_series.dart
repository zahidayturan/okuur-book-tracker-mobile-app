import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/series/series.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

class WeeklySeries extends StatefulWidget {

  const WeeklySeries({
    Key? key
  }) : super(key: key);

  @override
  State<WeeklySeries> createState() => _WeeklySeriesState();
}

class _WeeklySeriesState extends State<WeeklySeries> {

  AppColors colors = AppColors();
  HomeController controller = Get.find();

  @override
  void initState() {
    controller.fetchSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.seriesLoading.value
        ? ShimmerBox(height: 72, borderRadius: BorderRadius.circular(8))
        : seriesInfoWidget());
  }

  Container seriesInfoWidget(){
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (context, animation, nextanim) => const ReadingSeriesPage(),
                reverseTransitionDuration: const Duration(milliseconds: 1),
                transitionsBuilder: (context, animation, nexttanim, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                seriesInfo(controller.currentWeekInfo),
                seriesCountInfo(),
                iconButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row seriesInfo(List<Map<String, dynamic>> series) {
    List<Widget> seriesContainer = [];
    List<String> days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

    seriesContainer.add(const SizedBox(width: 12));
    bool isCurrentDay = false;
    for (int i = 0; i < series.length; i++) {
      if (series[i]['date'] != null) {
        if(series[i]['series'] != true){
          DateTime currentDate = DateTime.now();
          DateTime currentDayOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
          DateTime mapDate = series[i]['date'];
          DateTime mapDayOnly = DateTime(mapDate.year, mapDate.month, mapDate.day);
          isCurrentDay = currentDayOnly.isAtSameMomentAs(mapDayOnly);
        }
      }
      
      seriesContainer.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: series[i]['series'] == false ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.inversePrimary
                  ),
                  child: Visibility(
                      visible: isCurrentDay && series[i]['series'] == false,
                      child: const Icon(Icons.query_builder_rounded,size: 16)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            RegularText(
              texts:days[i],
              size: "xs",
              color: series[i]['series'] == false ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      );
      if (i < series.length - 1) {
        seriesContainer.add(const SizedBox(width: 7));
      }
    }
    return Row(
      children: seriesContainer,
    );
  }

  RichTextWidget seriesCountInfo(){
    return RichTextWidget(
      texts: ["${controller.activeSeriesInfo!.dayCount}\n","Günlük\nSeri"],
      colors: [Theme.of(context).colorScheme.secondary,Theme.of(context).colorScheme.secondary],
      fontFamilies: const ["FontBold","FontMedium"],
      fontSize: 13,
      align: TextAlign.center,
    );
  }

  SizedBox iconButton(){
    return SizedBox(
      height: 40,
      width: 16,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset("assets/icons/arrow.png",color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

}