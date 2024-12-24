import 'package:get/get.dart';

class BookDetailController extends GetxController {

  var bookId = Rx<String?>(null);

  void setBookId(String? image) {
    bookId.value = image;
  }

  void clearBookId() {
    bookId.value = null;
  }

}