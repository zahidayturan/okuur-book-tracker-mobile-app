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
    controller.fetchTotalStatistics(true);
    super.initState();
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
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  PageHeaderTitle(
                      title: "İstatistiklerin",
                      pathName: "assets/icons/navbar/stat_d.png",
                      subtitle: "Okumalarının analizini ve\ntakvimi görüntüle"
                  ).getTitle(context),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      totalAndSerialInfo(context),
                      const SizedBox(height: 12),
                      const MonthlyReadingInfo(),
                      const SizedBox(height: 12),
                      const WeeklyReadingInfo(),
                    ],
                  ),
                  const SizedBox(height: 70)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}