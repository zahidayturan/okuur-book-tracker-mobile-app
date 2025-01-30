import 'package:flutter/material.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';

Widget bestSeriesInfo(BuildContext context,int bestSeries){
  return Row(
    children: [
      Expanded(child: BaseContainer(
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const RegularText(texts: "En İyi\nSerin",maxLines: 2,size: "l"),
            BaseContainer(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(child: Column(
                  children: [
                    RegularText(texts: bestSeries.toString(),size: "l",weight: FontWeight.bold,),
                    const SizedBox(height: 4,),
                    const RegularText(texts: "Gün",size: "m")
                  ],
                )))
          ],
        ),
      )),
      const SizedBox(width: 12,),
      Expanded(child: BaseContainer(
        height: 72,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.ios_share_rounded,color: Theme.of(context).scaffoldBackgroundColor,size: 36,),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RegularText(texts: "Serini Paylaş",weight: FontWeight.bold),
                RegularText(texts: "Okuma serini\narkadaşlarınla paylaş",maxLines: 3,size: "s",)
              ],
            ),
          ],
        ),
      ),)
    ],
  );
}