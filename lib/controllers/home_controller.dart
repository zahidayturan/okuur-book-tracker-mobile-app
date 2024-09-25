import 'package:get/get.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';

class HomeController extends GetxController {

  List<OkuurBookInfo> currentlyReadBooks = [];
  BookOperations bookOperations = BookOperations();
  var booksLoading = Rx<bool>(false);


  Future<void> fetchCurrentlyReadBooks() async {
    booksLoading.value = true;
    currentlyReadBooks = await bookOperations.getCurrentlyReadBooksInfo();
    booksLoading.value = false;
  }

}
