import 'package:flutter/material.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';

Widget dailySeriesInfo(BuildContext context){
  return BaseContainer(
    height: 72,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RegularText(texts: "24 Ocak 2025",weight: FontWeight.bold),
            RegularText(texts: "Bugün bir okuma kaydederek\nserini uzat!",maxLines: 3,),
          ],
        ),
        SizedBox(
          width: 32,
          child: Image.asset("assets/icons/clock.png",color: Theme.of(context).colorScheme.secondary,),
        ),
      ],
    ),
  );
}