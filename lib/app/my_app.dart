import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/theme/theme.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/routes/login/welcome_app.dart';

class MyApp extends StatelessWidget {
  final User? currentUser;

  const MyApp({Key? key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OkuurController okuurController = Get.put(OkuurController());
    final OkuurLocalStorage storage = OkuurLocalStorage();
    final themeMode = okuurController.getTheme(storage.getTheme());
    okuurController.setSystemNavBarColor(MediaQuery.of(context).platformBrightness == Brightness.dark);

    return GetMaterialApp(
      title: 'Okuur',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('tr', ''),
      ],
      locale: const Locale('tr'),
      home: currentUser != null ? OkuurApp() : WelcomePage(),
    );
  }
}
