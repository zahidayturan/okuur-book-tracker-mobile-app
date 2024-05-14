import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class BottomNavBar extends StatefulWidget {


  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  AppColors colors = AppColors();

  int currentMode = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 54,
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
          decoration: BoxDecoration(
            color: colors.green,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getIconAndText(context, "assets/icons/home.png", "Ana Sayfa",0),
              getIconAndText(context, "assets/icons/statistics.png", "İstatistik",1),
              getIconAndText(context, "assets/icons/social.png", "Sosyal",2),
              getIconAndText(context, "assets/icons/library.png", "Kitaplık",3),
              getIconAndText(context, "assets/icons/other.png", "Diğer",4)
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector getIconAndText(BuildContext context,String path,String text,int mode){
    return GestureDetector(
      onTap: () {
        setState(() {
          currentMode = mode;
        });
      },
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

