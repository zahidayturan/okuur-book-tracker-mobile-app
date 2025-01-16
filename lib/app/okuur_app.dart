import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/controllers/library_controller.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/controllers/profile_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/library/library.dart';
import 'package:okuur/routes/profile/profile.dart';
import 'package:okuur/routes/social/social.dart';
import 'package:okuur/routes/statistics/statistics.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';
import 'package:okuur/ui/components/functional_alert_dialog.dart';

class OkuurApp extends StatefulWidget {
  const OkuurApp({
    Key? key,
  }) : super(key: key);

  @override
  State<OkuurApp> createState() => _OkuurAppState();
}

class _OkuurAppState extends State<OkuurApp> {
  AppColors colors = AppColors();
  late OkuurController controller;

  @override
  void initState() {
    super.initState();
    Get.put(OkuurController());
    Get.put(LibraryController());
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(BookDetailController());
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    Widget setWidget() {
      switch (controller.homePageCurrentMode.value) {
        case 0:
          return const HomePage();
        case 1:
          return const StatisticsPage();
        case 2:
          return const SocialPage();
        case 3:
          return const LibraryPage();
        case 5:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (controller.homePageCurrentMode.value != 0) {
          controller.homePageCurrentMode.value = 0;
          return false;
        } else {
          bool shouldExit = await _showCustomDialog(context);
          return shouldExit;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                setWidget(),
                const BottomNavBar()
          ])),
          extendBody: true,
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }

  Future<bool> _showCustomDialog(BuildContext context) async {
    bool? result = await OkuurAlertDialog.show(
      context: context,
      contentText: "Uygulamadan çıkmak mı istiyorsunuz?",
      buttons: [
        AlertButton(text: "Hayır", fill: false, returnValue: false),
        AlertButton(text: "Evet", fill: true, returnValue: true),
      ],
    );
    return result ?? false;
  }
}