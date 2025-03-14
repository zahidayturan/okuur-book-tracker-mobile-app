import 'package:get/get.dart';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_series_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/data/services/operations/series_operations.dart';
import 'package:okuur/data/services/operations/user_operations.dart';
import 'package:okuur/ui/utils/date_formatter.dart';

class HomeController extends GetxController {

  /*
  PROFILE
   */
  OkuurUserInfo? userInfo;
  var homeProfileLoading = Rx<bool>(false);

  Future<void> fetchProfile(bool fetch) async {
    if(fetch || userInfo == null){
      homeProfileLoading.value = true;
      userInfo = await UserOperations().getActiveUserInfoByUId();
      homeProfileLoading.value = false;
    }
  }

  /*
  CURRENTLY BOOKS
   */


  List<OkuurBookInfo> currentlyReadBooks = [];
  List<OkuurBookAndLogInfo> logForDate = [];

  BookOperations bookOperations = BookOperations();
  LogOperations logOperations = LogOperations();
  SeriesOperations seriesOperations = SeriesOperations();

  var logsLoading = Rx<bool>(false);
  var booksLoading = Rx<bool>(false);

  DateTime initDate = DateTime.now();

  Future<void> fetchLogForDate(bool fetch) async {
    if(fetch || logForDate.isEmpty){
      logsLoading.value = true;
      logForDate = await logOperations.getAllLogForDate(initDate);
      logsLoading.value = false;
    }
  }

  Future<void> fetchCurrentlyReadBooks(bool fetch) async {
    if(fetch || currentlyReadBooks.isEmpty){
      booksLoading.value = true;
      currentlyReadBooks = await bookOperations.getCurrentlyReadBooksInfo();
      currentlyReadBooks.sort((a, b) => a.startingDate.compareTo(b.startingDate));
      booksLoading.value = false;
    }
  }

  /*
  SERIES PAGE
   */

  var seriesLoading = Rx<bool>(false);
  OkuurSeriesInfo? activeSeriesInfo;
  int? bestSeriesInfo;
  bool dailySeries = false;
  Map<int, List<Map<String, dynamic>>>? monthlySeriesInfo;
  List<Map<String, dynamic>> currentWeekInfo = [];
  var seriesCalendarLoading = Rx<bool>(false);

  Future<void> fetchSeries(bool fetch) async {
    if(fetch || activeSeriesInfo == null){
      seriesLoading.value = true;
      activeSeriesInfo = await seriesOperations.getActiveSeriesInfo();

      if(activeSeriesInfo != null && activeSeriesInfo!.active){
        dailySeries = dailySeriesInfo(activeSeriesInfo!.finishingDate);
      }

      if(monthlySeriesInfo == null){
        await getDaysInMonth();
      }
      seriesLoading.value = false;
    }
  }

  Future<void> fetchSeriesCalendar(bool fetch) async {
    if(fetch || monthlySeriesInfo == null){
      seriesCalendarLoading.value = true;
      monthlySeriesInfo = await getDaysInMonth();
      seriesCalendarLoading.value = false;
    }
  }

  bool dailySeriesInfo(String? finishedDate){
    if(finishedDate != null){
      DateTime toDate = OkuurDateFormatter.stringToDateTime(finishedDate);
      DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      return now.isAtSameMomentAs(toDate) == false;
    }
    return false;
  }

  var seriesMonth = Rx<DateTime>(DateTime(DateTime.now().year, DateTime.now().month));

  void incrementMonth() {
    seriesMonth.value = DateTime(seriesMonth.value.year, seriesMonth.value.month + 1);
    fetchSeriesCalendar(true);
  }

  void decrementMonth() {
    seriesMonth.value = DateTime(seriesMonth.value.year, seriesMonth.value.month - 1);
    fetchSeriesCalendar(true);
  }

  void resetMonth() {
    seriesMonth.value = DateTime(DateTime.now().year, DateTime.now().month);
    fetchSeriesCalendar(true);
  }

  Future<Map<int, List<Map<String, dynamic>>>> getDaysInMonth() async {
    Map<int, List<Map<String, dynamic>>> monthMap = {};

    DateTime firstDayOfMonth = DateTime(seriesMonth.value.year, seriesMonth.value.month, 1);
    DateTime lastDayOfMonth = DateTime(seriesMonth.value.year, seriesMonth.value.month + 1, 0);

    int totalDaysInMonth = lastDayOfMonth.day;
    int startWeekday = (firstDayOfMonth.weekday + 6) % 7;

    DateTime dataFirstDate = firstDayOfMonth.subtract(Duration(days: startWeekday));
    int totalDayForNextMonth = (42 - (startWeekday + totalDaysInMonth));
    DateTime dataLastDate = lastDayOfMonth.add(Duration(days: totalDayForNextMonth));

    var result = await seriesOperations.getSeriesInfoForMonth(dataFirstDate, dataLastDate);
    List<DateTime> monthlySeries = result['seriesDates'];
    bestSeriesInfo = result['bestSeries'];

    List<Map<String, dynamic>> week = [];
    int currentWeek = 1;
    int nowWeekForReturn = 1;

    DateTime previousMonthLastDay = firstDayOfMonth.subtract(const Duration(days: 1));
    int previousMonthTotalDays = previousMonthLastDay.day;
    for (int i = startWeekday ; i > 0; i--) {
      DateTime previousMonthDate = DateTime(previousMonthLastDay.year, previousMonthLastDay.month, previousMonthTotalDays - i+1);
      bool isSeries = monthlySeries.contains(previousMonthDate);
      week.add({'date': previousMonthDate, 'series': isSeries, 'isFirst': false, 'isLast': false, 'isCur': false});
    }

    for (int day = 1; day <= totalDaysInMonth; day++) {
      DateTime currentDate = DateTime(seriesMonth.value.year, seriesMonth.value.month, day);
      bool isSeries = monthlySeries.contains(currentDate);

      bool isFirst = (day == 1 || currentDate.weekday == 1) ||
          (day > 1 && !monthlySeries.contains(DateTime(seriesMonth.value.year, seriesMonth.value.month, day - 1)) && isSeries);
      bool isLast = (day == totalDaysInMonth || currentDate.weekday == 7) ||
          (day < totalDaysInMonth &&
              !monthlySeries.contains(DateTime(seriesMonth.value.year, seriesMonth.value.month, day + 1)) &&
              isSeries);

      week.add({'date': currentDate, 'series': isSeries, 'isFirst': isFirst, 'isLast': isLast, 'isCur': true});

      if(currentDate == DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)){
        nowWeekForReturn = currentWeek;
      }
      if (week.length == 7) {
        monthMap[currentWeek] = List.from(week);
        week.clear();
        currentWeek++;
      }
    }

    DateTime nextMonthFirstDay = lastDayOfMonth.add(const Duration(days: 1));
    for (int i = 1; i <= totalDayForNextMonth; i++) {
      DateTime nextMonthDate = DateTime(nextMonthFirstDay.year, nextMonthFirstDay.month, i);
      bool isSeries = monthlySeries.contains(nextMonthDate);
      week.add({'date': nextMonthDate, 'series': isSeries, 'isFirst': false, 'isLast': false, 'isCur': false});

      if (week.length == 7) {
        monthMap[currentWeek] = List.from(week);
        week.clear();
        currentWeek++;
      }
    }

    currentWeekInfo = monthMap[nowWeekForReturn]!;

    return monthMap;
  }


/*
  READS PAGE
   */

  List<OkuurBookAndLogInfo> readsLogInfo = [];
  var readsLoading = Rx<bool>(false);

  Map<String, dynamic> totalReadsInfo = {};
  int? totalMonthlyReads;

  Future<void> fetchReadsPage(bool fetch) async {
    if(fetch || readsLogInfo.isEmpty){
      readsLoading.value = true;
      readsLogInfo = await logOperations.getMonthlyLogInfo(readsMonth.value);
      calculateReadsInfo(readsLogInfo);
      readsLoading.value = false;
    }
  }

  Map<String, dynamic> calculateReadsInfo(List<OkuurBookAndLogInfo> readsLogInfo) {
    if(readsLogInfo.isNotEmpty){
      DateTime firstLogDate = OkuurDateFormatter.stringToDateTime(readsLogInfo.first.okuurLogInfo.readingDate);

      int page = readsLogInfo.fold(0, (sum, log) => sum + log.okuurLogInfo.numberOfPages);
      int time = readsLogInfo.fold(0, (sum, log) => sum + log.okuurLogInfo.timeRead);

      if(DateTime.now().month == firstLogDate.month && DateTime.now().year == firstLogDate.year){
        totalMonthlyReads = page;
      }

      totalReadsInfo["page"] = page;
      totalReadsInfo["time"] = time;
      totalReadsInfo["point"] = ((2 * time * page) / (time + (page+1))).toStringAsFixed(0);
    }else{
      totalReadsInfo["page"] = 0;
      totalReadsInfo["time"] = 0;
      totalReadsInfo["point"] = 0;
    }
    return totalReadsInfo;
  }

  var readsMonth = Rx<DateTime>(DateTime(DateTime.now().year, DateTime.now().month));

  void readsIncrementMonth() {
    readsMonth.value = DateTime(readsMonth.value.year, readsMonth.value.month + 1);
    fetchReadsPage(true);
  }

  void readsDecrementMonth() {
    readsMonth.value = DateTime(readsMonth.value.year, readsMonth.value.month - 1);
    fetchReadsPage(true);
  }

  void readsResetMonth() {
    readsMonth.value = DateTime(DateTime.now().year, DateTime.now().month);
    fetchReadsPage(true);
  }

}