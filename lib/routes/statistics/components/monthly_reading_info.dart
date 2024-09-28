import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/statistics_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/circular_bar.dart';
import 'package:okuur/ui/components/rich_text.dart';

class MonthlyReadingInfo extends StatefulWidget {

  final int finishedPage;
  final int goalPage;

  const MonthlyReadingInfo({
    Key? key,
    required this.finishedPage,
    required this.goalPage,
  }) : super(key: key);

  @override
  State<MonthlyReadingInfo> createState() => _MonthlyReadingInfoState();
}

class _MonthlyReadingInfoState extends State<MonthlyReadingInfo> {

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
                    "${controller.selectedMonth.value} ${DateTime.now().year}",
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
                  texts: ["Okunan\n",widget.finishedPage.toString(),"\nSayfa"],
                  colors: [Theme.of(context).colorScheme.inversePrimary],
                  fontFamilies: const ["FontMedium","FontBold","FontMedium"]
              ),
              OkuurCircularProgressBar(
                size: 120,
                percentage: (widget.finishedPage/widget.goalPage),
                textColor: colors.blue,
                inSideColor: colors.grey,
                outSideColor: colors.blue,
              ),
              RichTextWidget(
                  texts: ["Hedef\n",widget.goalPage.toString(),"\nSayfa"],
                  colors: [Theme.of(context).colorScheme.secondary],
                  fontFamilies: const ["FontMedium","FontBold","FontMedium"],
                  align: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Text("Hedefin için günde en az 50 sayfa okumalısın. ",style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.secondary),textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  void _showMonthPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      barrierColor: colors.blackLight.withOpacity(0.8),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
      context: context,
      builder: (context) {
        return Obx(() {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.greenDark,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 18),
                  margin: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Listeden Ay Seçiniz",style: TextStyle(fontSize: 17,color: colors.grey,fontFamily: "FontBold"),),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Kapat",style: TextStyle(fontSize: 16,color: colors.grey),)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.months.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${controller.months[index]} ${DateTime.now().year}",style: TextStyle(color: Theme.of(context).colorScheme.secondary),textAlign: TextAlign.center,),
                        visualDensity: const VisualDensity(vertical: -1),
                        onTap: () {
                          controller.setMonth(controller.months[index]);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}