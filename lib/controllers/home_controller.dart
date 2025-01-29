import 'package:get/get.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';

class HomeController extends GetxController {

  List<OkuurBookInfo> currentlyReadBooks = [];
  List<OkuurLogInfo> logForDate = [];

  BookOperations bookOperations = BookOperations();
  LogOperations logOperations = LogOperations();

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

  var seriesMonth = Rx<DateTime>(DateTime(DateTime.now().year, DateTime.now().month));

  void incrementMonth() {
    seriesMonth.value = DateTime(seriesMonth.value.year, seriesMonth.value.month + 1);
  }

  void decrementMonth() {
    seriesMonth.value = DateTime(seriesMonth.value.year, seriesMonth.value.month - 1);
  }

  void resetMonth() {
    seriesMonth.value = DateTime(DateTime.now().year, DateTime.now().month,);
  }

  Map<int, List<Map<String, dynamic>>> getDaysInMonth() {
    Map<int, List<Map<String, dynamic>>> monthMap = {};
    DateTime firstDayOfMonth = DateTime(seriesMonth.value.year, seriesMonth.value.month, 1);
    DateTime lastDayOfMonth = DateTime(seriesMonth.value.year, seriesMonth.value.month + 1, 0);
    print(firstDayOfMonth);
    print(lastDayOfMonth);

    int totalDaysInMonth = lastDayOfMonth.day;
    int startWeekday = (firstDayOfMonth.weekday + 6) % 7;

    print(totalDaysInMonth);
    print(startWeekday);

    List<Map<String, dynamic>> week = [];
    int currentWeek = 1;

    for (int i = 0; i < startWeekday; i++) {
      week.add({'day': "", 'series': false});
    }

    for (int day = 1; day <= totalDaysInMonth; day++) {
      week.add({'day': day.toString(), 'series': true});

      if (week.length == 7) {
        monthMap[currentWeek] = List.from(week);
        week.clear();
        currentWeek++;
      }
    }

    while (week.length < 7) {
      week.add({'day': "", 'series': false});
    }

    if (week.isNotEmpty) {
      monthMap[currentWeek] = List.from(week);
    }

    print(monthMap);

    return monthMap;
  }


}
