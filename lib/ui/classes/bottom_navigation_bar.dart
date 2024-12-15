import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/library/library.dart';
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
      height: 64,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 54,
            decoration: BoxDecoration(
                color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                border: Border(top: BorderSide(width: 1,color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor?.withOpacity(0.3) ?? colors.grey.withOpacity(0.3)))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getIconAndText(context, "assets/icons/navbar/home", "Ana Sayfa",0,const HomePage()),
                getIconAndText(context, "assets/icons/navbar/stat", "İstatistik",1,const StatisticsPage()),
                getIconAndText(context, "assets/icons/navbar/social", "Sosyal",2,const SocialPage()),
                getIconAndText(context, "assets/icons/navbar/lib", "Kitaplık",3,const LibraryPage()),
                SizedBox(width: 54)
              ],
            ),
          ),
          Positioned(
              right: 16,
              child: addButton(context,"Ekle",4))
        ],
      ),
    );
  }

  Obx getIconAndText(BuildContext context,String path,String text,int mode,Widget pageName){
    return Obx(() => InkWell(
      onTap: () {
          controller.setHomePageCurrentMode(mode);
      },
      child: SizedBox(
        height: 54,
        width: 54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: mode == controller.homePageCurrentMode.value ? 24: 20,
                child:Image.asset(
                  mode== controller.homePageCurrentMode.value ? "${path}_a.png" : "${path}_d.png",
                  color:mode == controller.homePageCurrentMode.value ? Theme.of(context).colorScheme.secondary: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,),
              ),
            ),
            const SizedBox(height: 4,),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: mode == controller.homePageCurrentMode.value ? 0: 12,
              child: Text(text,style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                  fontFamily: "FontMedium",
                  overflow: TextOverflow.ellipsis
              ),),
            )
          ],
        ),
      ),
    ));
  }

  GestureDetector addButton(BuildContext context,String text,int mode){
    return GestureDetector(
      onTap: () {
        //controller.setHomePageCurrentMode(0);
      },
      child: Container(
        width: 54,
        height: 54,
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.add_rounded,color: colors.grey,size: 28),
          ),
        ),
      ),
    );
  }
}

