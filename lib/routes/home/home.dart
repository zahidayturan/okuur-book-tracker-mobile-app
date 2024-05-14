import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/componenets/current_book_and_discover.dart';
import 'package:okuur/routes/home/componenets/currently_reading_info.dart';
import 'package:okuur/routes/home/componenets/home_profile_info.dart';
import 'package:okuur/routes/home/componenets/mini_pages_info.dart';
import 'package:okuur/routes/home/componenets/operation_buttons.dart';
import 'package:okuur/routes/home/componenets/weekly_series.dart';
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
          padding: EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 12,),
                  HomeProfileInfo(userName: "Kullanıcı Adı",pageCount: 345),
                  SizedBox(height: 12,),
                  CurrentlyReadingInfo(bookName: "Kralın Dönüşü",currentPage: 180,bookPage: 360),
                  SizedBox(height: 12,),
                  SizedBox(height: 160,),
                  SizedBox(height: 12,),
                  OperationButtons(),
                  SizedBox(height: 12,),
                  CurrentBookAndDiscover(),
                  SizedBox(height: 12,),
                  WeeklySeries(weeklySeries: [1,0,1,0,0,1,1],currentSeries: 34),
                  SizedBox(height: 12,),
                  MiniPagesInfo(dailyGoal: 40,goalCount: 6,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}