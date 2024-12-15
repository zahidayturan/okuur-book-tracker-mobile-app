import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/home/components/current_book_and_discover.dart';
import 'package:okuur/routes/home/components/home_profile_info.dart';
import 'package:okuur/routes/home/components/mini_pages_info.dart';
import 'package:okuur/routes/home/components/weekly_calendar.dart';
import 'package:okuur/routes/home/components/weekly_series.dart';

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
        bottomNavigationBar: null,
        body: const Padding(
          padding: EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 18,),
                  HomeProfileInfo(userName: "Kullanıcı Adı",pageCount: 345),
                  SizedBox(height: 18,),
                  WeeklyCalendar(),
                  SizedBox(height: 18,),
                  CurrentBookAndDiscover(),
                  SizedBox(height: 18,),
                  WeeklySeries(weeklySeries: [1,1,1,1,0,0,0],currentSeries: 34),
                  SizedBox(height: 18,),
                  MiniPagesInfo(dailyGoal: 40,goalCount: 6,),
                  SizedBox(height: 64,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}