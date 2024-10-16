import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_google_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/routes/login/create_account.dart';
import 'package:okuur/routes/login/google_login.dart';
import 'package:okuur/routes/login/login_account.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/screens/internet_connection.dart';
import 'package:okuur/ui/utils/device_utils.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool internet = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  void checkInternetConnection() async {
    internet = await OkuurDeviceUtils.hasInternetConnection();
    setState(() {});
  }


  AppColors colors = AppColors();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child:
            size.height>400 ?
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 28,
                    child: Image.asset("assets/logo/logo_text.png",color: Theme.of(context).colorScheme.surface)),
                const SizedBox(height: 6,),
                body(),
                const SizedBox(),
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
                    const SizedBox(height: 16,),
                    SizedBox(
                        height: 28,
                        child: Image.asset("assets/logo/logo_text.png",color: Theme.of(context).colorScheme.surface)),
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
      margin: const EdgeInsets.symmetric(horizontal: 12),
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
                  texts: const ["Okuur'a"],
                  colors: [Theme.of(context).colorScheme.primary],
                  fontFamilies: const ["FontLight"],
                  fontSize: 22,
                  align: TextAlign.end),
              RichTextWidget(
                  texts: const ["Hoş\nGeldiniz"],
                  colors: [Theme.of(context).colorScheme.inversePrimary],
                  fontFamilies: const ["FontMedium"],
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
        turns: AlwaysStoppedAnimation(degree / 360),
        child: Container(
          width: 72,
          height: 54,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: colors.blackLight.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Align(
            alignment: Alignment.center,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-degree / 360),
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
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(36)),
        boxShadow: [
          BoxShadow(
            color: colors.greyDark.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          button("Yeni Hesap ","Oluştur",colors.blue,const CreateAccount()),
          const SizedBox(height: 12,),
          button("Hesabına ","Giriş Yap",colors.greenDark,const LoginAccount()),
          const SizedBox(height: 16,),
          orText(),
          const SizedBox(height: 16,),
          googleButton(),
          const SizedBox(height: 16,),
          RichTextWidget(
              texts: const ["Okuur, ","Fezai Tech ","tarafından geliştirilmiştir."],
              colors: [Theme.of(context).colorScheme.primary,Theme.of(context).colorScheme.primaryContainer,Theme.of(context).colorScheme.primary],
              fontFamilies: const ["FontMedium","FontBold","FontMedium"],
              fontSize: 9,
              align: TextAlign.center)
        ],
      ),
    );
  }

  InkWell button(String textL,String textB,Color color,Widget pageName){
    return InkWell(
      onTap: () {
        checkInternetConnection();
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            pageBuilder: (context, animation, nextanim) => internet == true ? pageName : const InternetConnection(),
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
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(50))
        ),
        child: Center(child: RichTextWidget(
            texts: [textL,textB],
            colors: [colors.grey],
            fontFamilies: const ["FontMedium","FontBold"],
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
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("veya",style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer,fontSize: 14,fontFamily: "FontMedium"),),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
          ),
        ),
      ],
    );
  }

  InkWell googleButton(){
    bool newUser = true;
    return InkWell(
      onTap: () async{
        checkInternetConnection();
        if(internet){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(
                color: colors.blue,
              ),
            );
          },
          barrierDismissible: false,
        );
        try {
          await _auth.currentUser?.reload();
          await FirebaseGoogleOperation().disconnectGoogle();
          newUser = await FirebaseGoogleOperation().signInWithGoogle();
        } finally {
          Navigator.pop(context);
          if (_auth.currentUser != null) {
            print('Successfully signed in with Google: ${_auth.currentUser!.displayName}');
            await OkuurLocalStorage().saveActiveUserUid(_auth.currentUser!.uid);
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, nextanim) => newUser == true ? const GoogleLogin() : const OkuurApp(),
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
        }
        }else {
          Get.to(() => InternetConnection());
        }
      },
      child: Row(
        children: [
          const Spacer(),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(24))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                      texts: const ["Google hesabın ile devam et"],
                      colors: [Theme.of(context).colorScheme.primaryContainer],
                      fontFamilies: const ["FontMedium"],
                      fontSize: 14,
                      align: TextAlign.center),
                ),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}