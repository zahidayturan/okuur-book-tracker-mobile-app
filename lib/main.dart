import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:okuur/app/init.dart';
import 'package:okuur/core/theme/theme.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/login/welcome_app.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okuur',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const WelcomePage(),
    );
  }
}


