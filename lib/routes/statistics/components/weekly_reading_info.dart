import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/statistics_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';

class WeeklyReadingInfo extends StatefulWidget {

  const WeeklyReadingInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<WeeklyReadingInfo> createState() => _WeeklyReadingInfoState();
}

class _WeeklyReadingInfoState extends State<WeeklyReadingInfo> {

  AppColors colors = AppColors();

  final StatisticsController controller = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(texts: "Son 7 Gün",size: "l",color: Theme.of(context).colorScheme.primaryContainer),
              InkWell(
                onTap: () {
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.greenDark,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Obx(() => Text(
                    controller.selectedWeeklyInfoType.value,
                    style: TextStyle(color: colors.grey),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              infoBar("Pt", 50, 15),
              infoBar("Sa", 50, 40),
              infoBar("Ça", 50, 25),
              infoBar("Pe", 50, 25),
              infoBar("Cu", 50, 50),
              infoBar("Ct", 50, 50),
              infoBar("Pa", 50, 50)
            ],
          ),
          const SizedBox(height: 12,),
          RichTextWidget(
              texts: const ["Okunan ","?"," Sayfa"],
              colors: [Theme.of(context).colorScheme.inversePrimary],
              fontFamilies: const ["FontMedium","FontBold","FontMedium"],
              align: TextAlign.center,
          ),
          const SizedBox(height: 12,),
          const RegularText(texts: "Günlük okuma hedefin ? sayfa.",size: "s",align: TextAlign.center)
        ],
      ),
    );
  }

  Widget infoBar(String text,int goal,int current){
    return LayoutBuilder(
      builder: (context, constraints) {
        int rate = calculateRate(goal,current);
        double innerContainerHeight = 64 * (rate/100);


        return Column(
          children: [
            RegularText(texts: text, color: colors.blueLight,size: "xs"),
            const SizedBox(height: 4,),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: 20,
                height: 64,
                decoration: BoxDecoration(
                  color: colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    width: 22,
                    height: innerContainerHeight,
                    decoration: BoxDecoration(
                      color: getColor(rate),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4,),
            RegularText(texts: current.toString(), color: Theme.of(context).colorScheme.primaryContainer,size: "xs"),
          ],
        );
      },
    );
  }

  Color getColor(int rate){
    if(rate >= 85){
      return colors.greenDark;
    } else if (60<=rate && rate<85){
      return colors.green;
    }else if (40<=rate && rate<60){
      return colors.blue;
    } else{
      return colors.blueLight;
    }
  }


  int calculateRate(int page,int currentPage){
    if(page > 0 && (currentPage < page)){
      return ((currentPage / page)*100).toInt();
    }else if(currentPage >= page){
      return 100;
    } else{
      return 0;
    }
  }

}