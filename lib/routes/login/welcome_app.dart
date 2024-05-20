import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_google_helper.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/login/create_account.dart';
import 'package:okuur/routes/login/login_account.dart';
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
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child:
            size.height>400 ?
            Column(
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
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    body(),
                    SizedBox(height: 16,),
                    SizedBox(
                        height: 28,
                        child: Image.asset("assets/logo/logo_text.png")),
                  ],
                )),
                Expanded(child: buttonContainer())],
            )
          ),
        ),
      ),
    );
  }

  Widget body(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              containerImage(colors.blue, "assets/icons/people.png", 20,Alignment.centerRight),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: containerImage(colors.green, "assets/icons/people_hand.png", -20,Alignment.centerLeft),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: containerImage(colors.greenDark, "assets/icons/reads.png", 20,Alignment.centerRight),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichTextWidget(
                  texts: ["Okuur'a"],
                  colors: [colors.blue],
                  fontFamilies: ["FontLight"],
                  fontSize: 22,
                  align: TextAlign.end),
              RichTextWidget(
                  texts: ["Hoş\nGeldiniz"],
                  colors: [colors.green],
                  fontFamilies: ["FontMedium"],
                  fontSize: 32,
                  align: TextAlign.end),
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
          width: 72,
          height: 54,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: colors.greyDark.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 4),
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
          borderRadius: BorderRadius.all(Radius.circular(36)),
        boxShadow: [
          BoxShadow(
            color: colors.greyDark.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          button("Yeni Hesap ","Oluştur",colors.blue,CreateAccount()),
          SizedBox(height: 12,),
          button("Hesabına ","Giriş Yap",colors.greenDark,LoginAccount()),
          SizedBox(height: 16,),
          orText(),
          SizedBox(height: 16,),
          googleButton(),
          SizedBox(height: 16,),
          RichTextWidget(
              texts: ["Okuur, ","Fezai Tech ","tarafından geliştirilmiştir."],
              colors: [colors.green,colors.greenDark,colors.green],
              fontFamilies: ["FontMedium","FontBold","FontMedium"],
              fontSize: 9,
              align: TextAlign.center)
        ],
      ),
    );
  }

  InkWell button(String textL,String textB,Color color,Widget pageName){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            pageBuilder: (context, animation, nextanim) => pageName,
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
        highlightColor: color,
        borderRadius: BorderRadius.all(Radius.circular(5)),
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
      onTap: () async{
        User? user = await FirebaseGoogleOperation().signInWithGoogle();
        if (user != null) {
          print(user.emailVerified);
          print('Successfully signed in with Google: ${user.displayName}');
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              opaque: false,
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, nextanim) => const HomePage(),
              reverseTransitionDuration: const Duration(milliseconds: 1),
              transitionsBuilder: (context, animation, nexttanim, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
           (Route<dynamic> route) => false,
          );
        } else {
          print('Failed to sign in with Google');
        }
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