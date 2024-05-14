import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/componenets/currently_reading_info.dart';
import 'package:okuur/routes/home/componenets/home_profile_info.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                HomeProfileInfo(userName: "Kullanıcı Adı",pageCount: 345),
                SizedBox(height: 12,),
                CurrentlyReadingInfo(bookName: "Kralın Dönüşü",currentPage: 180,bookPage: 360)
              ],
            ),
          ),
        ),
      ),
    );
  }
}