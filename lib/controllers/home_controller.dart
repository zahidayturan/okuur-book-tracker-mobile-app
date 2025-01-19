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

}
