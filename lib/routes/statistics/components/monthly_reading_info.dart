import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/statistics_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/circular_bar.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/shimmer_box.dart';
import 'package:okuur/ui/const/month_name_list.dart';

class MonthlyReadingInfo extends StatefulWidget {

  const MonthlyReadingInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthlyReadingInfo> createState() => _MonthlyReadingInfoState();
}

class _MonthlyReadingInfoState extends State<MonthlyReadingInfo> {

  AppColors colors = AppColors();

  final StatisticsController controller = Get.put(StatisticsController());

  @override
  void initState() {
    super.initState();
    controller.resetToCurrentMonth();
    controller.fetchMonthlyStatistics(true);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.statisticsMonthlyLoading.value
        ? ShimmerBox(height: 200, borderRadius: BorderRadius.circular(8))
        : body(context,controller.monthlyInfo!["page"],controller.monthlyInfo!["day"],controller.monthlyInfo!["remaining"],controller.monthlyInfo!["currentMonth"]));
  }

  Widget body(BuildContext context,int page, int day, int remaining, bool currentMonth){
    int goal = day*50;
    int minimumReading = remaining > 0 ? (goal-page)~/remaining : 0;
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
              Text("Aylık Okuma",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primaryContainer),),
              InkWell(
                onTap: () {
                  _showMonthPicker(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Obx(() => Text(
                    "${months[controller.statisticsMonth.value.month]} ${DateTime.now().year}",
                    style: TextStyle(color: colors.grey),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichTextWidget(
                  texts: ["Okunan\n",page.toString(),"\nSayfa"],
                  colors: [Theme.of(context).colorScheme.inversePrimary],
                  fontFamilies: const ["FontMedium","FontBold","FontMedium"]
              ),
              OkuurCircularProgressBar(
                size: 120,
                percentage: (page/goal),
                textColor: colors.blue,
                inSideColor: colors.grey,
                outSideColor: colors.blue,
              ),
              RichTextWidget(
                texts: ["Hedef\n",goal.toString(),"\nSayfa"],
                colors: [Theme.of(context).colorScheme.secondary],
                fontFamilies: const ["FontMedium","FontBold","FontMedium"],
                align: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(height: 12),
          RegularText(texts: minimumReading > 0 ? "Hedefin için günde en az $minimumReading sayfa okumalısın." : page >= goal ? "Hedefine ulaştın" : "Okuma yapmalısın",size: "s",align: TextAlign.center,)
        ],
      ),
    );
  }

  void _showMonthPicker(BuildContext context) {
    int range = DateTime.now().month+2 <=12 ? DateTime.now().month+2 : 12;
    List<String> monthList = months.sublist(1, range);
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      barrierColor: colors.blackLight.withOpacity(0.8),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
      context: context,
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.7,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.greenDark,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 14),
                  margin: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Listeden Ay Seçiniz",style: TextStyle(fontSize: 15,color: colors.grey,fontFamily: "FontBold"),),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Kapat",style: TextStyle(fontSize: 15,color: colors.grey),)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: monthList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${monthList[index]} ${DateTime.now().year}",style: TextStyle(color: Theme.of(context).colorScheme.secondary),textAlign: TextAlign.center,),
                        visualDensity: const VisualDensity(vertical: -1),
                        onTap: () {
                          controller.setMonth(index+1);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
      },
    );
  }
}