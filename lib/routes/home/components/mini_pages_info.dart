import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/reads/reads.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/snackbar.dart';

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
    return Column(
      children: [
        Row(
          children: [
            reads(),
            const SizedBox(width: 18),
            achievements(),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            goals(),
            const SizedBox(width: 18),
            discover()
          ],
        )
      ],
    );
  }
  
  Widget getBox(Widget child){
    return Expanded(
      child: Container(
        height: size,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: BorderRadius.circular(8),
          child: child
        ),
      ),
    );
  }

  Widget goals(){
    return getBox(
        InkWell(
          onTap: () {
            SnackBarWidget(context: context,duration: 3,backColor: colors.blackLight,textWidget: RegularText(texts: 'Okuur+\nAboneliği Gerektirir',maxLines: 2,color: colors.grey,align: TextAlign.center,)).showQuestionDialog();
          },
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 94,top: 24),
                child: Image.asset("assets/icons/goals.png",color: Theme.of(context).scaffoldBackgroundColor),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularText(texts: "Hedefler",color:Theme.of(context).colorScheme.onSurface,family: "FontBold"),
                    RegularText(
                      size: "s",
                      texts: "Günlük\n${widget.dailyGoal} sayfa",
                      maxLines: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RegularText(texts:"${widget.goalCount} tane", size: "xs"),
                        const RegularText(texts: "Göz at", size: "xs"),
                      ],)
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget achievements(){
    return getBox(
        InkWell(
          onTap: () {
            SnackBarWidget(context: context,duration: 3,backColor: colors.blackLight,textWidget: RegularText(texts: 'Okuur+\nAboneliği Gerektirir',maxLines: 2,color: colors.grey,align: TextAlign.center,)).showQuestionDialog();
          },
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 112,bottom: 38),
                child: Image.asset("assets/icons/achievements.png",color: Theme.of(context).scaffoldBackgroundColor),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularText(texts:"Başarımlar",color:Theme.of(context).colorScheme.onSurface,family: "FontBold"),
                    Center(child: Image.asset("assets/icons/achievements_example.png",color: Theme.of(context).colorScheme.secondary,height:52)),
                    const Align(alignment: Alignment.centerRight,child: RegularText(texts:"Görüntüle",size: "xs",))
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget reads(){
    return getBox(InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, animation, nextanim) => const AllReadsPage(),
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
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 84,top: 32),
            child: Image.asset("assets/icons/reads.png",color: Theme.of(context).scaffoldBackgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RegularText(texts:"Okumalar",color:Theme.of(context).colorScheme.onSurface,family: "FontBold"),
                const RegularText(texts:"Kaydettiğin bütün okumaların",  size: "s",maxLines: 3),
                const Align(alignment:Alignment.centerRight,child: RegularText(texts:"Listele", size: "xs"))
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget discover(){
    return getBox(InkWell(
      onTap: () {
        SnackBarWidget(context: context,duration: 3,backColor: colors.blackLight,textWidget: RegularText(texts: 'Okuur+\nAboneliği Gerektirir',maxLines: 2,color: colors.grey,align: TextAlign.center,)).showQuestionDialog();
      },
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 64,top: 16),
            child: Image.asset("assets/icons/connection.png",color:Theme.of(context).scaffoldBackgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RegularText(texts:"Keşfet",color:Theme.of(context).colorScheme.onSurface,family: "FontBold"),
                const RegularText(texts:"Okuyacak\nyeni kitaplar bul",size:"s",maxLines: 3),
                const Align(alignment: Alignment.centerRight,child: RegularText(texts:"Keşfet", size: "xs"))
              ],
            ),
          ),
        ],
      ),
    ));
  }

}