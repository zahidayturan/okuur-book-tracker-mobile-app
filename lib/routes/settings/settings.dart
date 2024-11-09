import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/settings/components/reading_settings.dart';
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
          padding: const EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  PageHeaderTitle(
                      backButton: true,
                      title: "Ayarlar",
                      pathName: "settings",
                      subtitle: "Uygulama içi tercihlerinizi ayarlayın"
                  ).getTitle(context),
                  const SizedBox(height: 24,),
                  OkuurSearchBar(hintText: "Ayarlar içerisinde arama yapın", onChanged: (value) {},),
                  const SizedBox(height: 24,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Görünüm", widget: const ThemeSettings()).getSettingBox(context),
                  const SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Dil", widget: const LanguageSettings()).getSettingBox(context),
                  const SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Hesap", widget: const AccountSettings()).getSettingBox(context),
                  const SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primary, title: "Okuma Tercihlerin", widget: const ReadingSettings()).getSettingBox(context),
                  const SizedBox(height: 12,),
                  SettingBox(color: Theme.of(context).colorScheme.primaryContainer, title: "Yedekleme", widget: const BackupSettings()).getSettingBox(context),
                  const SizedBox(height: 12,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}