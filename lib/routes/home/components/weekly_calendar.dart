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
  List<DateTime> weeks = [
    DateTime.now().subtract(Duration(days: 3)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now(),
    DateTime.now().add(Duration(days: 1)),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 3)),
  ];

  List<String> months = [
    "",
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];
  @override
  Widget build(BuildContext context) {
    return dayInfo();
  }

  Widget weekdays(){
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          arrowContainer(0),
          dayContainer(28,28, weeks[0], colors.greenDark, 12,"FontMedium",true),
          dayContainer(32,32, weeks[1], colors.greenDark, 13,"FontMedium",true),
          dayContainer(36,36, weeks[2], colors.greenDark, 14,"FontMedium",true),
          dayContainer(46,66, weeks[3], colors.green, 15,"FontBold",false),
          dayContainer(36,36, weeks[4], colors.greyDark, 14,"FontMedium",true),
          dayContainer(32,32, weeks[5], colors.greyDark, 13,"FontMedium",true),
          dayContainer(28,28, weeks[6], colors.greyDark, 12,"FontMedium",true),
          arrowContainer(1)
        ],
      ),
    );
  }

  Widget dayContainer(double height,double width,DateTime date,Color color,double fontSize,String family,bool isCircle){
    String dayInfo = "";
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
    }
    dayInfo = isSameDay(date, DateTime.now()) ? "Bugün" : months[date.month];

    int listIndex = weeks.indexWhere((element) => element == date);
    return GestureDetector(
      onTap: () {
        setState(() {
          if(listIndex == 0){
            weeks = weeks.map((date) => date.subtract(Duration(days: listIndex+3))).toList();
          }else if(listIndex==1){
            weeks = weeks.map((date) => date.subtract(Duration(days: listIndex+1))).toList();
          }else if(listIndex==2){
            weeks = weeks.map((date) => date.subtract(Duration(days: listIndex-1))).toList();
          }else if(listIndex>=4){
            weeks = weeks.map((date) => date.add(Duration(days: listIndex-3))).toList();
          }else{

          }

        });
      },
      onLongPress: () {
        setState(() {
          if(listIndex == 3){
            weeks = [
              DateTime.now().subtract(Duration(days: 3)),
              DateTime.now().subtract(Duration(days: 2)),
              DateTime.now().subtract(Duration(days: 1)),
              DateTime.now(),
              DateTime.now().add(Duration(days: 1)),
              DateTime.now().add(Duration(days: 2)),
              DateTime.now().add(Duration(days: 3)),
            ].toList();
          }
        });
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: isCircle == true ? 
          BorderRadius.all(Radius.circular(30)) :
            BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18)),
          color: color
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Text(
                  date.day.toString(),
                  key: ValueKey<int>(date.day),
                  style: TextStyle(
                    color: colors.white,
                    fontSize: fontSize,
                    fontFamily: family,
                  ),
                ),
              ),
              Visibility(
                visible: width != height,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Text(
                    dayInfo,
                    key: ValueKey<String>(dayInfo),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.white,
                      fontSize: 10,
                      fontFamily: "FontMedium",
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  GestureDetector arrowContainer(int type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          type == 0 ?
          weeks = weeks.map((date) => date.subtract(Duration(days: 1))).toList()
              :
          weeks = weeks.map((date) => date.add(Duration(days: 1))).toList();
        });
      },
      child: Container(
        height: 54,
        width: 18,
        padding: EdgeInsets.all(4),
        child: RotatedBox(
            quarterTurns: type == 0 ? 2 : 0,
            child: Image.asset("assets/icons/arrow.png", color: colors.blueLight)
        ),
      ),
    );
  }

  Container dayInfo(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: colors.white
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          weekdays(),
          SizedBox(height: 4,),
          title("Günlük Hedefe Ulaşıldı!", colors.green, 14, "FontMedium"),
          SizedBox(height: 4,),
          title("Kralın Dönüşü kitabından", colors.black, 13, "FontMedium"),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            iconAndText("assets/icons/page.png", "sayfa","48"),
            iconAndText("assets/icons/clock.png", "dakika","54"),
            iconAndText("assets/icons/point.png", "puan+","40"),
          ],),
          SizedBox(height: 8,),
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