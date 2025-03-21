import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/statistics_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

AppColors colors = AppColors();
StatisticsController controller = Get.find();

Widget totalAndSerialInfo(BuildContext context){
  return Obx(() => controller.statisticsTotalInfoLoading.value
      ? const ShimmerBox(height: 92,borderRadius: BorderRadius.all(Radius.circular(8)),)
      : SizedBox(
    height: 92,
    child: Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: totalWidget(controller.totalInfo!["book"],controller.totalInfo!["totalReading"],context),
          ),
        ),
        const SizedBox(width: 12,),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: serialWidget(context,controller.seriesInfo!["active"],controller.seriesInfo!["best"]),
          ),
        ),
      ],
    ),
  ));
}

Widget totalWidget(int bookCount,int pageCount,BuildContext context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Toplam Okuma",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primaryContainer,fontFamily: "FontBold"),),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichTextWidget(texts: [
              bookCount.toString(),"\nKitap"],
                colors: [Theme.of(context).colorScheme.inversePrimary],
                fontFamilies: const ["FontBold","FontMedium"],
                align: TextAlign.center,
                fontSize: 14,
            ),
            RichTextWidget(texts: [
              pageCount.toString(),"\nSayfa"],
              colors: [Theme.of(context).colorScheme.inversePrimary],
              fontFamilies: const ["FontBold","FontMedium"],
              align: TextAlign.center,
              fontSize: 14,
            ),
          ],
        ),
      )
    ],
  );
}

Widget serialWidget(BuildContext context,int currentlySerial,int maxSerial){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Seri",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primaryContainer,fontFamily: "FontBold"),),
          Container(
            constraints: const BoxConstraints(minWidth: 64),
           decoration: BoxDecoration(
             color: Theme.of(context).colorScheme.secondaryContainer,
             borderRadius: const BorderRadius.all(Radius.circular(50))
           ),
           padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
           child:  RichTextWidget(texts: [
             currentlySerial.toString(),"\nGün"],
             colors: [colors.grey],
             fontFamilies: const ["FontBold","FontMedium"],
             align: TextAlign.center,
             fontSize: 14,
           ),
         )
        ],
      ),
      RichTextWidget(texts: [
        "En İyi\n",maxSerial.toString(),"\nGün"],
        colors: [Theme.of(context).colorScheme.primaryContainer],
        fontFamilies: const ["FontMedium","FontBold","FontMedium"],
        align: TextAlign.end,
        fontSize: 14,
      ),


    ],
  );
}