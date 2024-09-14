import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/library/library.dart';
import 'package:okuur/routes/others/others.dart';
import 'package:okuur/routes/social/social.dart';
import 'package:okuur/routes/statistics/statistics.dart';

class BottomNavBar extends StatefulWidget {
  
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  AppColors colors = AppColors();
  
  @override
  void initState() {
    super.initState();
    Get.put(OkuurController());
  }

  OkuurController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.white,
        border: Border(top: BorderSide(width: 1,color: colors.greyDark.withOpacity(0.3)))
      ),
      child: Container(
        height: 54,
        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            getIconAndText(context, "assets/icons/home.png", "Ana Sayfa",0,HomePage()),
            getIconAndText(context, "assets/icons/statistics.png", "İstatistik",1,StatisticsPage()),
            getIconAndText(context, "assets/icons/social.png", "Sosyal",2,SocialPage()),
            getIconAndText(context, "assets/icons/library.png", "Kitaplık",3,LibraryPage()),
            getIconAndText(context, "assets/icons/other.png", "Diğer",4,OtherPage())
          ],
        ),
      ),
    );
  }

  Obx getIconAndText(BuildContext context,String path,String text,int mode,Widget pageName){
    return Obx(() => InkWell(
      onTap: () {
          controller.setHomePageCurrentMode(mode);
      },
      borderRadius: BorderRadius.all(Radius.circular(30)),
      highlightColor: colors.greenDark,
      child: AnimatedContainer(
        height: 54,
        width: 54,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mode == controller.homePageCurrentMode.value ? colors.greenDark : null
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: mode == controller.homePageCurrentMode.value ? 24: 20,
                child:Image.asset(path,color:mode == controller.homePageCurrentMode.value ? colors.white: colors.greenDark,),
              ),
            ),
            SizedBox(height: 4,),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: mode == controller.homePageCurrentMode.value ? 0: 12,
              child: Text(text,style: TextStyle(
                  fontSize: 10,
                  color: colors.greenDark,
                  fontFamily: "FontMedium",
                  overflow: TextOverflow.ellipsis
              ),),
            )
          ],
        ),
      ),
    ));
  }
}

