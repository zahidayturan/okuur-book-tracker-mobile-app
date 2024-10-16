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
          const SizedBox(height: 4,),
          weekdays(),
          const SizedBox(height: 12,),
          title("Günlük Hedefe Ulaşıldı!", Theme.of(context).colorScheme.inversePrimary, 14, "FontMedium",1),
          const SizedBox(height: 4,),
          dayInfo(),
          const SizedBox(height: 8,),
          OkuurPageSwitcher(pageCount: tempData.length,currentPage: currentPage,)
        ],
      ),
    );
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
          color: Theme.of(context).primaryColor,
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
              colors: [Theme.of(context).colorScheme.secondary],
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
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle
        ),
        padding: const EdgeInsets.all(6),
        child: RotatedBox(
            quarterTurns: type == 0 ? 2 : 0,
            child: Image.asset("assets/icons/arrow.png",color: Theme.of(context).colorScheme.secondary)
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
      height: 90,
      child: PageView.builder(
          itemCount: tempData.length,
          physics: BouncingScrollPhysics(),
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
                title("${list[index]["bookName"]} kitabından", Theme.of(context).colorScheme.secondary, 13, "FontMedium",2),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconAndText("assets/icons/page.png", "sayfa","${list[index]["page"]}"),
                    iconAndText("assets/icons/clock.png", "dakika","${list[index]["minute"]}"),
                    iconAndText("assets/icons/point.png", "puan+","${list[index]["point"]}"),
                  ],),
                const SizedBox(height: 8,),
                RichTextWidget(
                    texts: infoList[int.tryParse(list[index]["info"]!) ?? 0],
                    colors: [Theme.of(context).colorScheme.secondary],
                    fontFamilies: ["FontMedium","FontRegular","FontMedium"],
                    fontSize: 11,
                    align: TextAlign.center),
              ],
            );
          },
      ),
    );
  }

  Text title(String text,Color color,double size, String family,int maxLines){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size,
        overflow: TextOverflow.ellipsis
    ),
      maxLines: maxLines,
      textAlign: TextAlign.center,
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
            title(count, Theme.of(context).colorScheme.secondary, 13, "FontMedium",1),
            title(text, Theme.of(context).colorScheme.secondary, 11, "FontMedium",1),
          ],
        )
      ],
    );
  }

}