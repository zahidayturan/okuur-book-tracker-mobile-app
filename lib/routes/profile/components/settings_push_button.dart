import 'package:flutter/material.dart';
import 'package:okuur/routes/settings/settings.dart';

Widget settingsPush(BuildContext context){
  return SizedBox(
    height: 86,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (context, animation, nextanim) => const SettingsPage(),
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
          highlightColor: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: iconContainer(context, 36,36, Theme.of(context).colorScheme.onPrimaryContainer, "assets/icons/settings.png"),
        ),
      ],
    ),
  );
}

Container iconContainer(BuildContext context,double width,double height,Color color,String path){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(50))
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(path,color: Theme.of(context).colorScheme.secondary,),
    ),
  );
}