import 'package:get/get.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/models/okuur_series_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/data/services/operations/series_operations.dart';
import 'package:okuur/ui/utils/date_formatter.dart';

class HomeController extends GetxController {

  List<OkuurBookInfo> currentlyReadBooks = [];
  List<OkuurLogInfo> logForDate = [];

  BookOperations bookOperations = BookOperations();
  LogOperations logOperations = LogOperations();
  SeriesOperations seriesOperations = SeriesOperations();

  var logsLoading = Rx<bool>(false);
  var booksLoading = Rx<bool>(false);

  DateTime initDate = DateTime.now();

  Future<void> fetchLogForDate() async {
    logsLoading.value = true;
    logForDate = await logOperations.getAllLogForDate(initDate);
    logsLoading.value = false;
  }

  Future<void> fetchCurrentlyReadBooks() async {
    booksLoading.value = true;
    currentlyReadBooks = await bookOperations.getCurrentlyReadBooksInfo();
    currentlyReadBooks.sort((a, b) => a.startingDate.compareTo(b.startingDate));
    booksLoading.value = false;
  }

  /*
  SERIES PAGE
   */

  var seriesLoading = Rx<bool>(false);
  OkuurSeriesInfo? activeSeriesInfo;
  int? bestSeriesInfo;
  bool dailySeries = false;
  Map<int, List<Map<String, dynamic>>>? monthlySeriesInfo;
  var seriesCalendarLoading = Rx<bool>(false);

  Future<void> fetchSeries() async {
    seriesLoading.value = true;
    activeSeriesInfo = await seriesOperations.getActiveSeriesInfo();
    dailySeries = dailySeriesInfo(activeSeriesInfo!.finishingDate);
    seriesLoading.value = false;
  }

  Future<void> fetchSeriesCalendar() async {
    seriesCalendarLoading.value = true;
    monthlySeriesInfo = await getDaysInMonth();
    seriesCalendarLoading.value = false;
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
    fetchSeriesCalendar();
  }

  void decrementMonth() {
    seriesMonth.value = DateTime(seriesMonth.value.year, seriesMonth.value.month - 1);
    fetchSeriesCalendar();
  }

  void resetMonth() {
    seriesMonth.value = DateTime(DateTime.now().year, DateTime.now().month);
    fetchSeriesCalendar();
  }

  Future<Map<int, List<Map<String, dynamic>>>> getDaysInMonth() async {
    Map<int, List<Map<String, dynamic>>> monthMap = {};
    DateTime firstDayOfMonth = DateTime(seriesMonth.value.year, seriesMonth.value.month, 1);
    DateTime lastDayOfMonth = DateTime(seriesMonth.value.year, seriesMonth.value.month + 1, 0);

    var result = await seriesOperations.getSeriesInfoForMonth(firstDayOfMonth, lastDayOfMonth);
    List<DateTime> monthlySeries = result['seriesDates'];
    bestSeriesInfo = result['bestSeries'];

    int totalDaysInMonth = lastDayOfMonth.day;
    int startWeekday = (firstDayOfMonth.weekday + 6) % 7;

    List<Map<String, dynamic>> week = [];
    int currentWeek = 1;

    for (int i = 0; i < startWeekday; i++) {
      week.add({'date': null, 'series': false, 'isFirst': false, 'isLast': false});
    }

    for (int day = 1; day <= totalDaysInMonth; day++) {
      DateTime currentDate = DateTime(seriesMonth.value.year, seriesMonth.value.month, day);
      bool isSeries = monthlySeries.contains(currentDate);

      // Önceki günün series değeri false ise, ayın veya haftanın ilk günü ise, isFirst true olmalı
      bool isFirst = (day == 1 || currentDate.weekday == 1) ||
          (day > 1 && !monthlySeries.contains(DateTime(seriesMonth.value.year, seriesMonth.value.month, day - 1)) && isSeries);

      // Sonraki günün series değeri false ise, ayın veya heftanın son günü ise, isLast true olmalı
      bool isLast = (day == totalDaysInMonth || currentDate.weekday == 7) ||
          (day < totalDaysInMonth &&
              !monthlySeries.contains(DateTime(seriesMonth.value.year, seriesMonth.value.month, day + 1)) &&
              isSeries);

      week.add({'date': currentDate, 'series': isSeries, 'isFirst': isFirst, 'isLast': isLast});

      if (week.length == 7) {
        monthMap[currentWeek] = List.from(week);
        week.clear();
        currentWeek++;
      }
    }

    // Son hafta için eksik alanları doldur
    while (week.length < 7) {
      week.add({'date': null, 'series': false, 'isFirst': false, 'isLast': false});
    }

    if (week.isNotEmpty) {
      monthMap[currentWeek] = List.from(week);
    }

    return monthMap;
  }




}