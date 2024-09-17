import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/core/theme/theme.dart';
import 'package:okuur/routes/login/welcome_app.dart';

class MyApp extends StatelessWidget {
  final User? currentUser;

  const MyApp({Key? key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Okuur',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: currentUser != null ? OkuurApp() : WelcomePage(),
    );
  }
}
