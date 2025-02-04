import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/localizations/l10n_extension.dart';
import 'package:okuur/routes/addBook/add_book.dart';
import 'package:okuur/routes/addLog/add_log.dart';
import 'package:okuur/ui/components/regular_text.dart';

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

  bool toButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                border: Border(top: BorderSide(width: 2,color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor?.withOpacity(0.3) ?? colors.grey.withOpacity(0.3)))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(flex:1,child: getIconAndText(context, "assets/icons/navbar/home", context.translate.home_page,0)),
                Expanded(flex:1, child: getIconAndText(context, "assets/icons/navbar/stat", context.translate.statistics,1)),
                Expanded(flex:1, child: getIconAndText(context, "assets/icons/navbar/social", context.translate.social,2)),
                Expanded(flex:1, child: getIconAndText(context, "assets/icons/navbar/lib", context.translate.library,3)),
                const Expanded(flex:1, child: SizedBox())
              ],
            ),
          ),
          Positioned(
              right: 16,
              bottom: 124,
              child: toButton(context,context.translate.add_reading,4,colors.blueMid,const AddLogPage())),
          Positioned(
              right: 16,
              bottom: 74,
              child: toButton(context,context.translate.add_book,4,colors.green,const AddBookPage())),
          Positioned(
              right: 16,
              bottom: 12,
              child: addButton(context,"Ekle",4))
        ],
      ),
    );
  }

  Obx getIconAndText(BuildContext context,String path,String text,int mode){
    return Obx(() => InkWell(
      onTap: () {
          controller.setHomePageCurrentMode(mode);
          setState(() {
            toButtonVisible = false;
          });
      },
      child: SizedBox(
        height: 60,
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
                  color:mode == controller.homePageCurrentMode.value ? Theme.of(context).colorScheme.secondary: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
              ),
            ),
            const SizedBox(height: 4,),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: mode == controller.homePageCurrentMode.value ? 0: 12,
              child: RegularText(texts: text,
                  size: "xs",
                  color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
              ),)
          ],
        ),
      ),
    ));
  }

  GestureDetector addButton(BuildContext context,String text,int mode){
    return GestureDetector(
      onTap: () {
        setState(() {
          toButtonVisible = !toButtonVisible;
        });
      },
      child: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor?.withOpacity(0.3) ?? colors.grey.withOpacity(0.3),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: toButtonVisible ? colors.greenDark : colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(toButtonVisible ? Icons.close_rounded : Icons.add_rounded,color: colors.grey,size: 28),
          ),
        ),
      ),
    );
  }

  GestureDetector toButton(BuildContext context,String text,int mode,Color color,Widget pageName){
    return GestureDetector(
      onTap: () {
        setState(() {
          toButtonVisible = !toButtonVisible;
        });
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            pageBuilder: (context, animation, nextAnimation) {
              return pageName;
            },
            reverseTransitionDuration: const Duration(milliseconds: 1),
            transitionsBuilder: (context, animation, nextAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: toButtonVisible ? 40 : 0,
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Center(child: RegularText(texts: text,size: "m",color: colors.grey,)),
      ),
    );
  }
}

