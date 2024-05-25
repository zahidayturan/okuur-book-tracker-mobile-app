import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/core/theme/theme.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/login/welcome_app.dart';

class MyApp extends StatefulWidget {

  //final bool? showApp;

  const MyApp({
    Key? key,
    //required this.showApp,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  OkuurUserInfo? _userData;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    await _auth.currentUser?.reload();
    setState(() {
      _currentUser = _auth.currentUser;
      //_userData = FirebaseFirestoreOperation().getUserInfo(_currentUser!.uid);
    });

    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Okuur',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: _currentUser != null ? OkuurApp(pageIndex: 0) : WelcomePage() ,
    );
  }
}
