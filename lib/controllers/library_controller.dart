import 'package:get/get.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';

class LibraryController extends GetxController {
  var pageCurrentMode = RxInt(0);
  var isLoading = true.obs;

  void setPageCurrentMode(int pageCount) {
    pageCurrentMode.value = pageCount;
  }

  void clearPageCurrentMode() {
    pageCurrentMode.value = 0;
  }

  final BookOperations bookOperations = BookOperations();

  var currentBooks = <OkuurBookInfo>[].obs;
  var futureBooks = <OkuurBookInfo>[].obs;

  Future<void> fetchBooks() async {
    isLoading.value = true;
    List<OkuurBookInfo> books = await bookOperations.getBookInfo();
    List<OkuurBookInfo> current = [];
    List<OkuurBookInfo> future = [];
    List<OkuurBookInfo> past = [];

    for (var book in books) {
      int readStatus = book.status;
      if (readStatus == 0) {
        future.add(book);
      } else if (readStatus % 2 == 1) {
        current.add(book);
      } else {
        past.add(book);
      }
    }

    currentBooks.assignAll([...current, ...past]);
    futureBooks.assignAll(future);
    isLoading.value = false;
  }
}

