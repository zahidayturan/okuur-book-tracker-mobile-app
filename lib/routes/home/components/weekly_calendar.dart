import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/page_switcher.dart';
import 'package:okuur/ui/components/regular_text.dart';
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

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          weekdays(),
          const SizedBox(height: 12,),
          dayInfo(),
          const SizedBox(height: 12,),
          OkuurPageSwitcher(pageCount: tempData.length,currentPage: currentPage,)
        ],
      ),
    );
  }

  Widget weekdays(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        dayContainer(initDate),
        const SizedBox(width: 8),
        RegularText(texts:"Günlük Hedefe Ulaşıldı!", color: Theme.of(context).colorScheme.inversePrimary, size:"m"),
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
        constraints: const BoxConstraints(minWidth: 130),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
              colors: [Theme.of(context).colorScheme.secondary],
              fontFamilies: const ["FontBold", "FontMedium"],
              fontSize: 13,
              key: ValueKey<int>(date.day),
              align: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String,String>> tempData = [
    {
      "bookName":"Kralın Dönüşü",
      "page" : "46",
      "minute": "54",
      "point": "40",
      "info":"1"
    },
    {
      "bookName":"İki Kule",
      "page" : "40",
      "minute": "60",
      "point": "32",
      "info":"0"
    }
  ];

  List<List<String>> infoList = [
    ["Bu ","haftanın en uzun okumasını"," yaptın."],
    ["Bu ","haftanın en iyi okumasını"," yaptın."]
  ];

  SizedBox dayInfo(){
    return SizedBox(
      height: 98,
      child: PageView.builder(
          itemCount: tempData.length,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          itemBuilder: (context, index) {
            var list = tempData;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const RegularText(texts:"Okunan",otherSize: 10.0),
                RegularText(texts:"${list[index]["bookName"]}", size:"m", family: "FontBold",maxLines: 2),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconAndText("assets/icons/page.png", "sayfa","${list[index]["page"]}"),
                    iconAndText("assets/icons/clock.png", "dakika","${list[index]["minute"]}"),
                    iconAndText("assets/icons/point.png", "puan","${list[index]["point"]}"),
                  ],),
                const SizedBox(height: 8,),
                RichTextWidget(
                    texts: infoList[int.tryParse(list[index]["info"]!) ?? 0],
                    colors: [Theme.of(context).colorScheme.secondary],
                    fontFamilies: const ["FontMedium","FontRegular","FontMedium"],
                    fontSize: 11,
                    align: TextAlign.center),
              ],
            );
          },
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
            color: Theme.of(context).primaryColor
          ),
          padding: const EdgeInsets.all(5),
          child: Image.asset(path,color: Theme.of(context).colorScheme.secondary,),
        ),
        const SizedBox(width: 4,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(texts:count, size: "m"),
            RegularText(texts:text,  size: "xs"),
          ],
        )
      ],
    );
  }

}