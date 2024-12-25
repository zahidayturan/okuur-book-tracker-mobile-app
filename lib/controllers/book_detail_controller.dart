import 'package:get/get.dart';

class BookDetailController extends GetxController {

  var bookId = Rx<String?>(null);

  void setBookId(String? image) {
    bookId.value = image;
  }

  void clearBookId() {
    bookId.value = null;
  }

  var detailLoading = Rx<bool>(false);

  Future<void> getBookDetail() async {
    detailLoading.value = true;

    detailLoading.value = false;
  }

}