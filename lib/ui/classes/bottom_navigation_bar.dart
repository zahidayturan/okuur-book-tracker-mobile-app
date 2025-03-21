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
      height: 172,
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
              right: 20,
              bottom: 74,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 600),
                scale: toButtonVisible ? 1 : 0,
                alignment: Alignment.bottomRight,
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    toButton(context,context.translate.add_reading,4,colors.blueMid,const AddLogPage(),Icons.add_circle_outline_rounded),
                    const SizedBox(height: 8),
                    toButton(context,context.translate.add_book,4,colors.green,const AddBookPage(),Icons.my_library_books_outlined)
                  ],
                ),
              )),
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

  Container addButton(BuildContext context,String text,int mode){
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(2),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: toButtonVisible ? colors.greenDark : colors.orange,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                toButtonVisible = !toButtonVisible;
              });
            },
            borderRadius: BorderRadius.circular(50),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(toButtonVisible ? Icons.close_rounded : Icons.add_rounded,color: colors.grey,size: 28),
            ),
          ),
        ),
      ),
    );
  }

  Widget toButton(BuildContext context,String text,int mode,Color color,Widget pageName,IconData icon){
    return Material(
      child: Ink(
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
          gradient: LinearGradient(
              stops:  const [0.28, 0.28],
              transform: const GradientRotation(60),
              colors: [colors.greenDark, color]
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
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
          child: Container(
            constraints: const BoxConstraints(minWidth: 150),
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RegularText(texts: text,color: colors.grey),
                Icon(icon,size: 22,color: colors.grey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

