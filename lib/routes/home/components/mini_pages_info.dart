import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import '../../../ui/components/rich_text.dart';

class MiniPagesInfo extends StatefulWidget {

  final int dailyGoal;
  final int goalCount;

  const MiniPagesInfo({
    Key? key,
    required this.dailyGoal,
    required this.goalCount
  }) : super(key: key);

  @override
  State<MiniPagesInfo> createState() => _MiniPagesInfoState();
}

class _MiniPagesInfoState extends State<MiniPagesInfo> {

  AppColors colors = AppColors();

  double size = 110;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          goals(),
          SizedBox(width: 12,),
          achievements(),
          SizedBox(width: 12,),
          reads(),
          SizedBox(width: 12,),
          discover()
        ],
      ),
    );
  }

  Widget goals(){
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 48,top: 24),
            child: Image.asset("assets/icons/goals.png",color: Theme.of(context).scaffoldBackgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title("Hedefler",Theme.of(context).colorScheme.onSurface,14,"FontBold"),
                RichTextWidget(
                    fontSize: 12,
                    texts: ["Günlük\n","${widget.dailyGoal} sayfa"],
                    colors: [Theme.of(context).colorScheme.secondary],
                    fontFamilies: ["FontMedium","FontBold"]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  title("${widget.goalCount} tane", Theme.of(context).colorScheme.secondary, 10, "FontMedium"),
                  title("Göz at", Theme.of(context).colorScheme.surface, 10, "FontMedium"),
                ],)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget achievements(){
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 48,bottom: 24),
            child: Image.asset("assets/icons/achievements.png",color: Theme.of(context).scaffoldBackgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title("Başarımlar",Theme.of(context).colorScheme.onSurface,14,"FontBold"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/icons/achievements_example.png",color: Theme.of(context).colorScheme.secondary,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    title("Görüntüle", Theme.of(context).colorScheme.surface, 10, "FontMedium"),
                  ],)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reads(){
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8,top: 48),
            child: Image.asset("assets/icons/reads.png",color: Theme.of(context).scaffoldBackgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title("Okumalar",Theme.of(context).colorScheme.onSurface,14,"FontBold"),
                title("Kaydettiğin bütün okumaların", Theme.of(context).colorScheme.secondary, 12, "FontMedium"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    title("Listele", Theme.of(context).colorScheme.surface, 10, "FontMedium"),
                  ],)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget discover(){
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 48,top: 16),
            child: Image.asset("assets/icons/connection.png",color:Theme.of(context).scaffoldBackgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title("Keşfet",Theme.of(context).colorScheme.onSurface,14,"FontBold"),
                title("Okuyacak yeni kitaplar bul", Theme.of(context).colorScheme.secondary, 12, "FontMedium"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    title("Keşfet", Theme.of(context).colorScheme.surface, 10, "FontMedium"),
                  ],)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text title(String text,Color color,double size, String family) {
    return Text(
      text, style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),
    );
  }

}