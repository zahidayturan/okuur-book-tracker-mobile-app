import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

class WeeklyCalendar extends StatefulWidget {

  //get BookInfo

  const WeeklyCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        weekdays(),
        SizedBox(height: 4,),
        dayInfo()
      ],
    );
  }

  Widget weekdays(){
    return Container(
      height: 54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          arrowContainer(0),
          dayContainer(30,30, DateTime(2024,8,2), colors.greenDark, 13,"FontMedium"),
          dayContainer(34,34, DateTime(2024,8,3), colors.greenDark, 14,"FontMedium"),
          dayContainer(38,38, DateTime(2024,8,4), colors.greenDark, 14,"FontMedium"),
          dayContainer(42,58, DateTime(2024,8,5), colors.green, 15,"FontBold"),
          dayContainer(38,38, DateTime(2024,8,6), colors.greyDark, 14,"FontMedium"),
          dayContainer(34,34, DateTime(2024,8,7), colors.greyDark, 14,"FontMedium"),
          dayContainer(30,30, DateTime(2024,8,8), colors.greyDark, 13,"FontMedium"),
          arrowContainer(1)

        ],
      ),
    );
  }

  Container dayContainer(double height,double width,DateTime date,Color color,double fontSize,String family){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: color
      ),
      child: Center(
        child: Text(
          date.day.toString(),
          style: TextStyle(
            color: colors.white,
            fontSize: fontSize,
            fontFamily: family
          ),
        ),
      ),

    );
  }

  Container arrowContainer(int type){
    return Container(
      height: 20,
      child: RotatedBox(
        quarterTurns: type == 0 ? 2 : 0,
          child: Image.asset("assets/icons/arrow.png",color: colors.blueLight)),
    );
  }

  Container dayInfo(){
    return Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: colors.white
      ),
      padding: EdgeInsets.only(bottom: 8,left: 8,right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 54,
            height: 6,
            decoration: BoxDecoration(
              color: colors.green,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))
            ),
          ),
          title("Günlük Hedefe Ulaşıldı!", colors.green, 14, "FontMedium"),
          title("Kralın Dönüşü kitabından", colors.black, 13, "FontMedium"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            iconAndText("assets/icons/page.png", "sayfa","48"),
            iconAndText("assets/icons/clock.png", "dakika","54"),
            iconAndText("assets/icons/point.png", "puan+","40"),
          ],),
          RichTextWidget(
              texts: ["Bu ","haftanın en iyi okumasını"," yaptın."],
              colors: [colors.black,colors.black,colors.black],
              fontFamilies: ["FontMedium","FontRegular","FontMedium"],
              fontSize: 11,
              align: TextAlign.center)
        ],
      ),
    );
  }

  Text title(String text,Color color,double size, String family){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),
    );
  }
  
  Row iconAndText(String path,String text,String count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.blueLight
          ),
          padding: EdgeInsets.all(5),
          child: Image.asset(path,color: colors.white,),
        ),
        SizedBox(width: 4,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(count, colors.black, 13, "FontMedium"),
            title(text, colors.black, 11, "FontMedium"),
          ],
        )
      ],
    );
  }


}