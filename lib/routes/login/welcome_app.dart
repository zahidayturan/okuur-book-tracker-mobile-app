import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';
import 'package:okuur/ui/components/rich_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 28,
                    child: Image.asset("assets/logo/logo_text.png")),
                SizedBox(height: 6,),
                body(),
                SizedBox(),
                buttonContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget body(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              containerImage(colors.blueLight, "assets/icons/people.png", 20,Alignment.centerRight),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: containerImage(colors.blue, "assets/icons/people_hand.png", -20,Alignment.centerLeft),
              ),
            ],
          ),
          RichTextWidget(
              texts: ["Hoş\nGeldiniz"],
              colors: [colors.greenDark],
              fontFamilies: ["FontMedium"],
              fontSize: 28,
              align: TextAlign.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              containerImage(colors.green, "assets/icons/reads.png", 20,Alignment.centerRight),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: containerImage(colors.greenDark, "assets/icons/star.png", -20,Alignment.centerLeft),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget containerImage(Color color,String path,double degree,AlignmentGeometry align){
    return SizedBox(
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(degree / 360),
        child: Container(
          width: 84,
          height: 64,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: colors.greyDark.withOpacity(0.4),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),

          child: Align(
            alignment: Alignment.center,
            child: RotationTransition(
              turns: new AlwaysStoppedAnimation(-degree / 360),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset(path),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buttonContainer(){
    return Container(
      height: 260,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.all(Radius.circular(36))
      ),
      child: Column(
        children: [
          button("Yeni Hesap ","Oluştur",colors.blue),
          SizedBox(height: 12,),
          button("Hesabına ","Giriş Yap",colors.greenDark ),
          SizedBox(height: 16,),
          orText(),
          SizedBox(height: 16,),
          googleButton(),
          SizedBox(height: 16,),
          RichTextWidget(
              texts: ["Okuur ","Fezai Tech ","tarafından geliştirilmiştir."],
              colors: [colors.green,colors.greenDark,colors.green],
              fontFamilies: ["FontMedium","FontBold","FontMedium"],
              fontSize: 9,
              align: TextAlign.center)
        ],
      ),
    );
  }

  InkWell button(String textL,String textB,Color color){
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        child: Center(child: RichTextWidget(
            texts: [textL,textB],
            colors: [colors.white,colors.white],
            fontFamilies: ["FontMedium","FontBold"],
            fontSize: 16,
            align: TextAlign.center)),
      )
    );
  }

  Row orText(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              color: colors.greenDark,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("veya",style: TextStyle(color: colors.greenDark,fontSize: 14,fontFamily: "FontMedium"),),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
                color: colors.greenDark,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        ),
      ],
    );
  }

  InkWell googleButton(){
    return InkWell(
      onTap: () {

      },
      child: Row(
        children: [
          Spacer(),
          Container(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(24))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      color: colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/icons/google.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichTextWidget(
                      texts: ["Google hesabın ile devam et"],
                      colors: [colors.greenDark],
                      fontFamilies: ["FontMedium"],
                      fontSize: 14,
                      align: TextAlign.center),
                ),
              ],
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}