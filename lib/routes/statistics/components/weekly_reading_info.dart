import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/statistics_controller.dart';
import 'package:okuur/core/constants/colors.dart';
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
              Text("Son 7 Gün",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primaryContainer),),
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
              infoBar("Pt", 50, 42),
              infoBar("Sa", 50, 24),
              infoBar("Ça", 50, 64),
              infoBar("Pe", 50, 12),
              infoBar("Cu", 50, 36),
              infoBar("Ct", 50, 50),
              infoBar("Pa", 50, 4)
            ],
          ),
          const SizedBox(height: 12,),
          RichTextWidget(
              texts: const ["Okunan ","310"," Sayfa"],
              colors: [Theme.of(context).colorScheme.tertiary],
              fontFamilies: const ["FontMedium","FontBold","FontMedium"],
              align: TextAlign.center,
          ),
          const SizedBox(height: 12,),
          Text("Günlük okuma hedefin 40 sayfa.",style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.secondary),textAlign: TextAlign.center,)
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
            Text(text, style: TextStyle(color: colors.blueLight,fontSize: 11)),
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
            Text(current.toString(), style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer,fontSize: 11)),
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