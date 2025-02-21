import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/data/services/operations/series_operations.dart';

class StatisticsController extends GetxController {

  HomeController homeController = Get.put(HomeController());
  LogOperations logOperations = LogOperations();
  BookOperations bookOperations = BookOperations();
  SeriesOperations seriesOperations = SeriesOperations();
  /*
  Total Info
   */

  var statisticsTotalInfoLoading = Rx<bool>(false);
  Map<String,dynamic>? totalInfo;
  Map<String,dynamic>? seriesInfo;
  Future<void> fetchTotalStatistics(bool fetch) async {
    if (fetch || totalInfo == null) {
      statisticsTotalInfoLoading.value = true;
      totalInfo = await bookOperations.getTotalBookAndPage();
      seriesInfo = await seriesOperations.getBestAndActiveSeriesInfo();
      statisticsTotalInfoLoading.value = false;
    }
  }

  /*
  Monthly Info
   */
  var statisticsMonthlyLoading = Rx<bool>(false);
  Map<String,dynamic>? monthlyInfo;
  List<OkuurBookAndLogInfo> monthlyLogInfo = [];

  Future<void> fetchMonthlyStatistics(bool fetch) async {
    if (fetch || monthlyInfo == null) {
      statisticsMonthlyLoading.value = true;

      DateTime today = DateTime.now();

      DateTime lastDayOfMonth = DateTime(statisticsMonth.value.year, statisticsMonth.value.month + 1, 0);
      int remainingDays = lastDayOfMonth.difference(today).inDays;

      monthlyLogInfo = await logOperations.getMonthlyLogInfo(statisticsMonth.value);

      monthlyInfo = homeController.calculateReadsInfo(monthlyLogInfo);

      monthlyInfo!["day"] = lastDayOfMonth.day;
      monthlyInfo!["currentMonth"] = today.month == lastDayOfMonth.month;
      monthlyInfo!["remaining"] = today.month == lastDayOfMonth.month ? remainingDays : 0;

      statisticsMonthlyLoading.value = false;
    }
  }

  var statisticsMonth = Rx<DateTime>(DateTime(DateTime.now().year, DateTime.now().month));

  void setMonth(int index) {
    statisticsMonth.value = DateTime(DateTime.now().year,index);
    fetchMonthlyStatistics(true);
  }

  void resetToCurrentMonth() {
    statisticsMonth.value = DateTime(DateTime.now().year,DateTime.now().month);
    fetchMonthlyStatistics(true);
  }

  /*
  Weekly Info
  */

  var statisticsWeeklyLoading = Rx<bool>(false);
  List<Map<String, dynamic>> lastSevenDayLogInfo = [];
  int sevenDayTotalRead = 0;

  Future<void> fetchWeeklyStatistics(bool fetch) async {
    if (fetch || lastSevenDayLogInfo.isEmpty) {
      statisticsWeeklyLoading.value = true;

      DateTime today = DateTime.now();
      List<DateTime> lastSevenDays = List.generate(7, (i) => today.subtract(Duration(days: i)));
      lastSevenDays = lastSevenDays.reversed.toList();

      try {
        List<Future<Map<String, dynamic>>> fetchLogs = lastSevenDays.map((day) async {
          List<OkuurLogInfo> dayList = await logOperations.getDailyLogInfo(day);
          int dayTotalRead = dayList.fold(0, (total, inDay) => total + inDay.numberOfPages);

          return {
            'totalRead': dayTotalRead,
            'day': day,
          };
        }).toList();

        lastSevenDayLogInfo = await Future.wait(fetchLogs);

        sevenDayTotalRead = lastSevenDayLogInfo.fold(0, (total, item) {
          int dayTotalRead = item["totalRead"] ?? 0;
          return total + dayTotalRead;
        });

      } catch (e) {
        debugPrint('Veri alınırken hata oluştu fetchW: $e');
      } finally {
        statisticsWeeklyLoading.value = false;
      }
    }
  }

}

