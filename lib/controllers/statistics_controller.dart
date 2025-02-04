import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';

class StatisticsController extends GetxController {

  HomeController homeController = Get.put(HomeController());
  LogOperations logOperations = LogOperations();
  BookOperations bookOperations = BookOperations();
  /*
  Total Info
   */

  var statisticsTotalInfoLoading = Rx<bool>(false);
  Map<String,dynamic>? totalInfo;
  Future<void> fetchTotalStatistics(bool fetch) async {
    if (fetch || totalInfo == null) {
      statisticsTotalInfoLoading.value = true;
      totalInfo = await bookOperations.getTotalBookAndPage();
      statisticsTotalInfoLoading.value = false;
    }
  }

  /*
  Monthly and Weekly
   */
  var statisticsMonthlyLoading = Rx<bool>(false);
  Map<String,dynamic>? monthlyInfo;
  List<OkuurHomeLogInfo> monthlyLogInfo = [];
  List<OkuurLogInfo> lastSevenDayLogInfo = [];

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
      /*
      List<DateTime> lastSevenDays = List.generate(7, (i) {
        return today.subtract(Duration(days: i));
      }).toList();

      lastSevenDayLogInfo.clear();

      for (var log in monthlyLogInfo) {
        DateTime logDate = OkuurDateFormatter.stringToDateTime(log.okuurLogInfo.readingDate);

        if (lastSevenDays.contains(logDate)) {
          lastSevenDayLogInfo.add(log.okuurLogInfo);
        }
      }*/
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

  var selectedWeeklyInfoType = "Sayfa".obs;
}

