import 'package:get/get.dart';
import 'package:okuur/data/models/dto/book_detail_info.dart';
import 'package:okuur/data/models/okuur_book_info.dart';

class BookDetailController extends GetxController {

  OkuurBookInfo? okuurBookInfo;
  OkuurBookDetailInfo? okuurBookDetailInfo;

  var bookId = Rx<String?>(null);

  void setBookInfo(OkuurBookInfo? okuurBookInfo) {
    this.okuurBookInfo = okuurBookInfo;
  }

  var detailLoading = Rx<bool>(false);

  Future<void> getBookDetail() async {
    detailLoading.value = true;
    okuurBookDetailInfo = null;
    detailLoading.value = false;
  }

}