import 'package:get/get.dart';
import 'package:okuur/data/models/dto/book_detail_info.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';

class BookDetailController extends GetxController {

  BookOperations bookOperations = BookOperations();
  LogOperations logOperations = LogOperations();

  OkuurBookInfo? okuurBookInfo;
  OkuurBookDetailInfo? okuurBookDetailInfo;
  List<OkuurLogInfo> logs= [];

  var bookId = Rx<String?>(null);

  void setBookInfo(OkuurBookInfo? okuurBookInfo) {
    this.okuurBookInfo = okuurBookInfo;
    bookId.value = okuurBookInfo!.id!;
  }

  var detailLoading = Rx<bool>(false);

  Future<void> getBookDetail() async {
    if(bookId.value != null){
      detailLoading.value = true;
      logs = await logOperations.getLogInfo(bookId.value!);
      detailLoading.value = false;
    }else{
      print("else detail controller");
    }
  }

}