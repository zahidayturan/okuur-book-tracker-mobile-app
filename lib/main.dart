import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/app/my_app.dart';
import 'package:okuur/core/utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  await Firebase.initializeApp();
  User? currentUser;
  try {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      currentUser = FirebaseAuth.instance.currentUser;
    }
  } catch (e) {
    print('Error initializing user: $e');
  }

  runApp(MyApp(currentUser: currentUser));
}
