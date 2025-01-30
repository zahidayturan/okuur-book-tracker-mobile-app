import 'package:flutter/material.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';

Widget activeSeriesInfo(BuildContext context,int activeSeries){
  return BaseContainer(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const RegularText(texts: "Aktif\nOkuma Serin",maxLines: 2,size: "xl"),
        BaseContainer(
            height: 54,
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Center(child: Row(
              children: [
                RegularText(texts: activeSeries.toString(),color: colors.grey,size: "xxl",weight: FontWeight.bold,),
                const SizedBox(width: 4,),
                RegularText(texts: "Gün",color: colors.grey,size: "xl")
              ],
            )))
      ],
    ),
  );
}
