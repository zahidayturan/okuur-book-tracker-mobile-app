import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/core/utils/firebase_google_helper.dart';
import 'package:okuur/routes/login/welcome_app.dart';
import 'package:okuur/routes/settings/components/ReadingSettings.dart';
import 'package:okuur/routes/settings/components/account_settings.dart';
import 'package:okuur/routes/settings/components/backup_settings.dart';
import 'package:okuur/routes/settings/components/language_settings.dart';
import 'package:okuur/routes/settings/components/setting_box.dart';
import 'package:okuur/routes/settings/components/theme_settings.dart';
import 'package:okuur/ui/components/page_header.dart';
import 'package:okuur/ui/components/search_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  AppColors colors = AppColors();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 12,),
                  PageHeaderTitle(
                      backButton: true,
                      title: "Ayarlar",
                      pathName: "settings",
                      subtitle: "Uygulama içi tercihlerinizi ayarlayın"
                  ).getTitle(context),
                  SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: OkuurSearchBar(hintText: "Ayarlar içerisinde arama yapın", onChanged: (value) {},),
                  ),
                  SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Görünüm", widget: ThemeSettings()).getSettingBox(context),
                  SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Dil", widget: LanguageSettings()).getSettingBox(context),
                  SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Hesap", widget: AccountSettings()).getSettingBox(context),
                  SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primary, title: "Okuma Tercihlerin", widget: ReadingSettings()).getSettingBox(context),
                  SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Yedekleme", widget: BackupSettings()).getSettingBox(context),
                  SizedBox(height: 12,),
                  InkWell(
                    onTap: () async{
                      await FirebaseGoogleOperation().disconnectGoogle();
                      await FirebaseAuthOperation().deleteAccountAndSignOut();
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
                      height: 26,
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
                      await FirebaseGoogleOperation().signOutGoogle();
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
                      height: 26,
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
                  SizedBox(height: 12,),
                  Text(_auth.currentUser != null ? _auth.currentUser!.email.toString() : "E posta"),
                  Text(_auth.currentUser != null ? _auth.currentUser!.uid : "uid"),
                  Text(_auth.currentUser != null ? _auth.currentUser!.emailVerified.toString() : "verified"),
                  Text(_auth.currentUser != null ? _auth.currentUser!.providerData.length ==  1 ? _auth.currentUser!.providerData[0].providerId : "${_auth.currentUser!.providerData[0].providerId} - ${_auth.currentUser!.providerData[1].providerId}" : "Hesap Türü"),
                  SizedBox(height: 12,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}