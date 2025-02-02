import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/series/components/active_series_info.dart';
import 'package:okuur/routes/series/components/best_series_info.dart';
import 'package:okuur/routes/series/components/daily_series_info.dart';
import 'package:okuur/routes/series/components/series_calendar_info.dart';
import 'package:okuur/ui/components/page_header.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

class ReadingSeriesPage extends StatefulWidget {
  const ReadingSeriesPage({super.key});

  @override
  State<ReadingSeriesPage> createState() => _ReadingSeriesPageState();
}

class _ReadingSeriesPageState extends State<ReadingSeriesPage> {

  AppColors colors = AppColors();
  HomeController controller = Get.find();

  @override
  void initState() {
    controller.resetMonth();
    //controller.fetchSeries();
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
                  const SizedBox(height: 12),
                  PageHeaderTitle(
                      title: "Okuma Serin",
                      pathName: "assets/icons/time.png",
                      subtitle: "",
                      backButton: true
                  ).getTitle(context),
                  Obx(() => controller.seriesLoading.value
                      ? const Column(
                    children: [
                      ShimmerBox(height: 72,borderRadius: BorderRadius.all(Radius.circular(8))),
                      SizedBox(height: 12),
                    ],
                  )
                      : Column(
                    children: [
                      activeSeriesInfo(context,controller.activeSeriesInfo?.dayCount ?? 0),
                      const SizedBox(height: 12),
                      seriesCalendarInfo(),
                      const SizedBox(height: 12),
                      dailySeriesInfo(context,controller.dailySeries),
                      const SizedBox(height: 12),
                      bestSeriesInfo(context, controller.bestSeriesInfo ?? 0),
                    ],
                  )),
                  const SizedBox(height: 12)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}