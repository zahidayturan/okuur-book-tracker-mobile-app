import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/statistics_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/statistics/components/monthly_reading_info.dart';
import 'package:okuur/routes/statistics/components/total_and_serial_info.dart';
import 'package:okuur/routes/statistics/components/weekly_reading_info.dart';
import 'package:okuur/ui/components/page_header.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  AppColors colors = AppColors();
  final StatisticsController controller = Get.put(StatisticsController());

  @override
  void initState() {
    super.initState();
    controller.resetToCurrentMonth();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  PageHeaderTitle(
                      title: "İstatistiklerin",
                      pathName: "statistics",
                      subtitle: "Okumalarının analizini ve\ntakvimi görüntüle"
                  ).getTitle(context),
                  const SizedBox(height: 16),
                  totalAndSerialInfo(context,"484","42","9760","34","84"),
                  const SizedBox(height: 12),
                  const MonthlyReadingInfo(finishedPage: 900,goalPage: 1200),
                  const SizedBox(height: 12),
                  WeeklyReadingInfo(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text text(String text,Color color,double size, String family,int maxLines){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),overflow: TextOverflow.ellipsis,maxLines: maxLines,
    );
  }
}