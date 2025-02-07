import 'package:flutter/material.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/regular_text.dart';

Widget bookGoal(){
  return BaseContainer(
    radius: 12,
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RegularText(texts: "Bitirme Hedefin",style: FontStyle.italic),
            RegularText(texts: "? gün",size: "m")
          ],
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            double outerContainerHeight = constraints.maxWidth;
            int rate = 0;
            double innerContainerWidth = outerContainerHeight * (rate/100);
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 18,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: innerContainerWidth,
                      decoration: BoxDecoration(
                        color: colors.orange,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const RegularText(texts: "Başlangıç ?",size: "s"),
            RegularText(texts: "Kalan ? gün",size: "m",color: colors.orange,)
          ],
        ),
      ],
    ),
  );
}