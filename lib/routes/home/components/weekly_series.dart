import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';

class WeeklySeries extends StatefulWidget {


  final List<int> weeklySeries;
  final int currentSeries;


  const WeeklySeries({
    Key? key,
    required this.weeklySeries,
    required this.currentSeries
  }) : super(key: key);

  @override
  State<WeeklySeries> createState() => _WeeklySeriesState();
}

class _WeeklySeriesState extends State<WeeklySeries> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            seriesInfo(widget.weeklySeries),
            seriesCountInfo(),
            iconButton()
          ],
        ),
      ),
    );
  }

  Row seriesInfo(List<int> series) {
    List<Widget> seriesContainer = [];
    List<String> days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

    seriesContainer.add(const SizedBox(width: 12,));

    for (int i = 0; i < series.length; i++) {
      seriesContainer.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: series[i] == 0 ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.inversePrimary
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            RegularText(
              texts:days[i],
              size: "xs",
              color: series[i] == 0 ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      );
      if (i < series.length - 1) {
        seriesContainer.add(const SizedBox(width: 7));
      }
    }
    return Row(
      children: seriesContainer,
    );
  }

  RichTextWidget seriesCountInfo(){
    return RichTextWidget(
      texts: ["${widget.currentSeries}\n","Günlük\nSeri"],
      colors: [Theme.of(context).colorScheme.secondary,Theme.of(context).colorScheme.secondary],
      fontFamilies: const ["FontBold","FontMedium"],
      fontSize: 13,
      align: TextAlign.center,
    );
  }

  SizedBox iconButton(){
    return SizedBox(
      height: 40,
      width: 16,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset("assets/icons/arrow.png",color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

}