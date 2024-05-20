import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:okuur/app/my_app.dart';
import 'package:okuur/core/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

