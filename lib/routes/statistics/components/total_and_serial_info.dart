import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

AppColors colors = AppColors();

Widget totalAndSerialInfo(BuildContext context,String totalDate,String bookCount,String pageCount,String currentlySerial,String maxSerial){
  return SizedBox(
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
            child: totalWidget(totalDate,bookCount,pageCount,context),
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
            child: serialWidget(context,currentlySerial,maxSerial),
          ),
        ),
      ],
    ),
  );
}

Widget totalWidget(String totalDate,String bookCount,String pageCount,BuildContext context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Toplam",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primaryContainer,fontFamily: "FontBold"),),
          Text("$totalDate gündür",style: TextStyle(fontSize: 11,color: Theme.of(context).colorScheme.secondary),)
        ],
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichTextWidget(texts: [
              bookCount,"\nKitap"],
                colors: [Theme.of(context).colorScheme.inversePrimary],
                fontFamilies: const ["FontBold","FontMedium"],
                align: TextAlign.center,
                fontSize: 14,
            ),
            RichTextWidget(texts: [
              pageCount,"\nSayfa"],
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

Widget serialWidget(BuildContext context,String currentlySerial,String maxSerial){
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
             currentlySerial,"\nGün"],
             colors: [colors.grey],
             fontFamilies: const ["FontBold","FontMedium"],
             align: TextAlign.center,
             fontSize: 14,
           ),
         )
        ],
      ),
      RichTextWidget(texts: [
        "En İyi\n",maxSerial,"\nGün"],
        colors: [Theme.of(context).colorScheme.primaryContainer],
        fontFamilies: const ["FontMedium","FontBold","FontMedium"],
        align: TextAlign.end,
        fontSize: 14,
      ),


    ],
  );
}