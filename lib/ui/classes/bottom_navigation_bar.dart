import 'package:flutter/material.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/statistics/statistics.dart';

class BottomNavBar extends StatefulWidget {

  final int pageIndex;
  const BottomNavBar({
    Key? key,
    required this.pageIndex
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  AppColors colors = AppColors();

  int currentMode = 0;
  @override
  void initState() {
    currentMode = widget.pageIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: colors.white,
        border: Border(top: BorderSide(width: 1,color: colors.greyDark.withOpacity(0.2)))
      ),
      child: Stack(
        children: [
          Container(
            height: 54,
            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
            decoration: BoxDecoration(
              color: colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getIconAndText(context, "assets/icons/home.png", "Ana Sayfa",0,HomePage()),
                getIconAndText(context, "assets/icons/statistics.png", "İstatistik",1,StatisticsPage()),
                getIconAndText(context, "assets/icons/social.png", "Sosyal",2,HomePage()),
                getIconAndText(context, "assets/icons/library.png", "Kitaplık",3,HomePage()),
                getIconAndText(context, "assets/icons/other.png", "Diğer",4,HomePage())
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell getIconAndText(BuildContext context,String path,String text,int mode,Widget pageName){
    return InkWell(
      onTap: () {
        setState(() {
          currentMode = mode;
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 100),
              pageBuilder: (context, animation, nextanim) => OkuurApp(pageIndex: currentMode),
              reverseTransitionDuration: const Duration(milliseconds: 1),
              transitionsBuilder: (context, animation, nexttanim, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        });
      },
      borderRadius: BorderRadius.all(Radius.circular(30)),
      highlightColor: colors.greenDark,
      child: AnimatedContainer(
        height: 60,
        width: 60,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mode == currentMode ? colors.greenDark : null
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: mode == currentMode ? 28: 24,
                child:Image.asset(path),
              ),
            ),
            SizedBox(height: 4,),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: mode == currentMode ? 0: 12,
              child: Text(text,style: TextStyle(
                fontSize: 10,
                color: colors.grey,
                fontFamily: "FontMedium",
                overflow: TextOverflow.ellipsis
              ),),
            )
          ],
        ),
      ),
    );
  }
}

