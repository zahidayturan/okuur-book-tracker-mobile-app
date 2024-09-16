import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/page_switcher.dart';
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

  DateTime initDate = DateTime.now();

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        arrowContainer(0),
        const SizedBox(width: 8,),
        dayContainer(initDate),
        const SizedBox(width: 8,),
        arrowContainer(1)
      ],
    );
  }

  Widget dayContainer(DateTime date) {
    String dayInfo = "";
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
    }
    dayInfo = isSameDay(date, DateTime.now()) ? "Bugün" : "${date.year}";

    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null && selectedDate != initDate) {
          setState(() {
            initDate = selectedDate;
          });
        }
      },
      onLongPress: () {
        setState(() {
          initDate = DateTime.now();
        });
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 160),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14)),
          color: colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: RichTextWidget(
              texts: ["${date.day.toString()} ${months[date.month]} ", dayInfo],
              colors: [colors.white, colors.white],
              fontFamilies: ["FontBold", "FontMedium"],
              fontSize: 14,
              key: ValueKey<int>(date.day),
              align: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }


  GestureDetector arrowContainer(int type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          type == 0 ?
          initDate = initDate.subtract(const Duration(days: 1))
              :
          initDate = initDate.add(const Duration(days: 1));
        });
      },
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: colors.grey,
          shape: BoxShape.circle
        ),
        padding: const EdgeInsets.all(6),
        child: RotatedBox(
            quarterTurns: type == 0 ? 2 : 0,
            child: Image.asset("assets/icons/arrow.png",color: colors.blue)
        ),
      ),
    );
  }

  Container dayInfo(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: colors.white
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 4,),
          weekdays(),
          const SizedBox(height: 12,),
          title("Günlük Hedefe Ulaşıldı!", colors.green, 14, "FontMedium"),
          const SizedBox(height: 4,),
          title("Kralın Dönüşü kitabından", colors.black, 13, "FontMedium"),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            iconAndText("assets/icons/page.png", "sayfa","48"),
            iconAndText("assets/icons/clock.png", "dakika","54"),
            iconAndText("assets/icons/point.png", "puan+","40"),
          ],),
          const SizedBox(height: 8,),
          RichTextWidget(
              texts: ["Bu ","haftanın en iyi okumasını"," yaptın."],
              colors: [colors.black,colors.black,colors.black],
              fontFamilies: ["FontMedium","FontRegular","FontMedium"],
              fontSize: 11,
              align: TextAlign.center),
          const SizedBox(height: 8,),
          OkuurPageSwitcher(pageCount: 2, onChanged: (value) {},)
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
          padding: const EdgeInsets.all(5),
          child: Image.asset(path,color: colors.white,),
        ),
        const SizedBox(width: 4,),
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