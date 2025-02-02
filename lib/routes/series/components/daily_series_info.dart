import 'package:flutter/material.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/utils/date_formatter.dart';

Widget dailySeriesInfo(BuildContext context, bool dailySeries){
  return BaseContainer(
    height: 72,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RegularText(texts: OkuurDateFormatter.getDateNowFormat(), weight: FontWeight.bold ,color: !dailySeries ? colors.green : null,),
            RegularText(texts: dailySeries ? "Bugün bir okuma kaydederek\nserini uzat!"
              : "Bugün bir okuma kaydederek\nserini devam ettirdin.",maxLines: 3),
          ],
        ),
        SizedBox(
          width: 32,
          child: Image.asset(dailySeries ?"assets/icons/clock.png" : "assets/icons/reads.png",color: dailySeries ? Theme.of(context).colorScheme.secondary : colors.green,),
        ),
      ],
    ),
  );
}