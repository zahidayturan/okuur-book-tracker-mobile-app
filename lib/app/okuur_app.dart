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
import 'package:okuur/ui/components/regular_text.dart';

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
          bool shouldExit = await _showExitConfirmation(context);
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

  Future<bool> _showExitConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))
        ),
        title: const RegularText(texts: 'Uygulamadan çıkmak mı istiyorsunuz?',align: TextAlign.center,size: "xl"),
        actions: [
          Row(
            children: [
              getAlertButton("Hayır",false,false),
              const SizedBox(width: 8,),
              getAlertButton("Evet",true,true),
            ],
          )
        ],
      ),
    ) ??
        false;
  }

  Expanded getAlertButton(String text,bool isPop,bool fill){
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.of(context).pop(isPop),
        child: Container(
            height: 36,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: fill ? colors.blue : null,
                border: fill ? null : Border.all(color: colors.blue,width: 1)
            ),
            child: Center(child: RegularText(texts: text,color: fill ? colors.white : colors.blue))),
      ),
    );
  }
}