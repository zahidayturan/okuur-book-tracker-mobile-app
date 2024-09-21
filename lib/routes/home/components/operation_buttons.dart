import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/addLog/add_log.dart';

class OperationButtons extends StatefulWidget {


  const OperationButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<OperationButtons> createState() => _OperationButtonsState();
}

class _OperationButtonsState extends State<OperationButtons> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          addForRead(),
          SizedBox(width: 12,),
          recordForRead(),
        ],
      ),
    );
  }

  Widget addForRead(){
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        highlightColor: colors.orange,
        onTap: () {
          Navigator.push(
            Get.context!,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 100),
              pageBuilder: (context, animation, nextanim) => const AddLogPage(),
              reverseTransitionDuration: const Duration(milliseconds: 1),
              transitionsBuilder: (context, animation, nexttanim, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(

                      children:  [
                        TextSpan(
                            text: "Okuduklarını\n",
                            style: TextStyle(
                                fontFamily: "FontMedium", fontSize: 13, color: Theme.of(context).colorScheme.secondary
                            )),
                        TextSpan(
                            text: "Kaydet",
                            style: TextStyle(
                                fontFamily: "FontBold", fontSize: 14,color: colors.orange
                            )),
                      ]
                  ),
                ),
                iconButton("assets/icons/add.png",Theme.of(context).colorScheme.onBackground,0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget recordForRead(){
    return Expanded(
      child: GestureDetector(
        onTap: () {

        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconButton("assets/icons/play.png",Theme.of(context).colorScheme.onSecondary,1),
                RichText(
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      children: [
                    TextSpan(
                      text: "Okuma Modunu\n",
                      style: TextStyle(
                        fontFamily: "FontMedium", fontSize: 13 ,color: Theme.of(context).colorScheme.secondary
                      )),
                    TextSpan(
                        text: "Başlat",
                        style: TextStyle(
                            fontFamily: "FontBold", fontSize: 14, color: colors.blue
                        )),
                  ]
                  ),
                ),
              ],
            ),
          ),
        ),
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

  Container iconButton(String path,Color color,int type){
    double radius1 = type == 0 ? 25 : 85;
    double radius2 = type == 0 ? 85 : 25;
    return Container(
      height: 46,
      width: 28,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius1),
            bottomLeft: Radius.circular(radius1),
          bottomRight: Radius.circular(radius2),
          topRight: Radius.circular(radius2)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Image.asset(path,color: colors.grey,),
      ),
    );
  }
}