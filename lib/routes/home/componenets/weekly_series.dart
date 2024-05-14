import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
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
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: colors.green
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                color: colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: series[i] == 0 ? colors.grey : colors.greenDark
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              days[i],
              style: TextStyle(
                fontSize: 10,
                color: colors.white,
                fontFamily: "FontMedium"
              ),
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
  Column seriesCountInfo(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 2,),
        RichTextWidget(
          texts: ["${widget.currentSeries}\n","Günlük\n","Seri"],
          colors: [colors.grey,colors.grey,colors.grey],
          fontFamilies: const ["FontBold","FontBold","FontMedium"],
          fontSize: 13,
          align: TextAlign.center,
        ),
        Container(
          width: 54,
          height: 6,
          decoration: BoxDecoration(
            color: colors.greenDark,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
          ),
        )
      ],

    );
  }

  Container iconButton(){
    return Container(
      height: 40,
      width: 16,
      decoration: BoxDecoration(
          color: colors.grey,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset("assets/icons/arrow.png"),
      ),
    );
  }


}