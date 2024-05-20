import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/theme/theme.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/login/welcome_app.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool user(){
    return _auth.currentUser != null ?  true :  false;
  }

  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okuur',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: user() != true ? WelcomePage() : HomePage()
    );
  }
}