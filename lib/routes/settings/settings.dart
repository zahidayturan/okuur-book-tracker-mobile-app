import 'package:flutter/material.dart';
import 'package:okuur/app/my_app.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/routes/login/welcome_app.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavBar(pageIndex: 9,),
        body: Padding(
          padding: EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 12,),
                  InkWell(
                    onTap: () async{
                      await FirebaseAuthOperation().userDelete();
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (context, animation, nextanim) => const WelcomePage(),
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
                    },
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(
                        child: Text(
                          "Hesabı Sil",
                          style: TextStyle(
                            color: colors.white,
                            fontSize: 16,
                            fontFamily: "FontMedium"
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  InkWell(
                    onTap: () async{
                      await FirebaseAuthOperation().userSignOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (context, animation, nextanim) => const WelcomePage(),
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
                    },
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                          color: colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(
                        child: Text(
                          "Hesaptan Çıkış Yap",
                          style: TextStyle(
                              color: colors.white,
                              fontSize: 16,
                              fontFamily: "FontMedium"
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}