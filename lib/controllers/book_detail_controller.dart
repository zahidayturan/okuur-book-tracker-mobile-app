import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:okuur/data/models/dto/book_detail_info.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/ui/components/loading_circular.dart';

class BookDetailController extends GetxController {

  BookOperations bookOperations = BookOperations();
  LogOperations logOperations = LogOperations();

  OkuurBookInfo? okuurBookInfo;
  OkuurBookDetailInfo? okuurBookDetailInfo;
  List<OkuurLogInfo> logs= [];

  var isLogChanged = Rx<bool>(false);

  var bookId = Rx<String?>(null);

  void setBookInfo(OkuurBookInfo? okuurBookInfo) {
    this.okuurBookInfo = okuurBookInfo;
    bookId.value = okuurBookInfo!.id!;
  }

  var detailLoading = Rx<bool>(false);

  Future<void> getBookDetail() async {
    if (bookId.value != null) {
      try {
        detailLoading.value = true;
        logs = await logOperations.getLogInfo(bookId.value!);
        logs.sort((a, b) => b.readingDate.compareTo(a.readingDate));
        detailLoading.value = false;
      } catch (error) {
        detailLoading.value = false;
        debugPrint("Error fetching log info: $error");
      }
    } else {
      debugPrint("bookId is null, unable to fetch book details");
    }
  }

  Future<void> deleteLogInfo(OkuurLogInfo okuurLogInfo) async {
    LoadingDialog.showLoading(message: "Kayıt siliniyor");
    try {
      await logOperations.deleteLogInfo(okuurLogInfo);
      await bookOperations.updateBookInfoAfterLog(okuurLogInfo,false);
      setBookInfo(await bookOperations.getBookInfoWithId(okuurLogInfo.bookId));
      getBookDetail();
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    } finally {
      LoadingDialog.hideLoading();
    }
  }

  Future<void> deleteBook(OkuurBookInfo bookInfo) async {
    LoadingDialog.showLoading(message: "Kitap siliniyor");
    try {
      await bookOperations.deleteBookAndLogInfo(bookInfo.id!);
    } catch (e) {
      debugPrint("An error occurred: $e");
    } finally {
      LoadingDialog.hideLoading();
      Navigator.pop(Get.context!, true);
    }
  }
  /*
  EDIT
   */

  final bookNameKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();

  var isAllChanged = Rx<bool>(false);
  void editChangeDetect() {
    if(bookNameController.text != okuurBookInfo!.name && bookNameController.text.isNotEmpty){
      isAllChanged.value = true;
      print("change ");
    }else{
      isAllChanged.value = false;
    }
  }


}