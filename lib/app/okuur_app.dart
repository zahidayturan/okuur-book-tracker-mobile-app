import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/library/library.dart';
import 'package:okuur/routes/others/others.dart';
import 'package:okuur/routes/profile/profile.dart';
import 'package:okuur/routes/social/social.dart';
import 'package:okuur/routes/statistics/statistics.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';

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
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    Widget setWidget() {
      switch (controller.homePageCurrentMode.value) {
        case 0:
          return HomePage();
        case 1:
          return StatisticsPage();
        case 2:
          return SocialPage();
        case 3:
          return LibraryPage();
        case 4:
          return OtherPage();
        case 5:
          return ProfilePage();
        default:
          return HomePage();
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
          body: Obx(() => setWidget()),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavBar(),
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
        title: const Text('Uygulamadan çıkmak mı istiyorsunuz?',textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
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
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: fill ? colors.blue : null,
                border: fill ? null : Border.all(color: colors.blue,width: 1)
            ),
            child: Center(child: Text(text,style: TextStyle(color: fill ? colors.white : colors.blue),))),
      ),
    );
  }
}