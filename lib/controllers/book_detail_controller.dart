import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void editInit(OkuurBookInfo okuurBookInfo) {
    bookNameController.text = okuurBookInfo.name;
    bookAuthorController.text = okuurBookInfo.author;
    bookPageController.text = okuurBookInfo.pageCount.toString();
    bookTypeController.text = okuurBookInfo.type;
    isAllChanged.value = false;
  }

  final bookNameKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();

  final bookAuthorKey = GlobalKey<FormState>();
  final TextEditingController bookAuthorController = TextEditingController();

  final bookPageKey = GlobalKey<FormState>();
  final TextEditingController bookPageController = TextEditingController();

  final bookTypeKey = GlobalKey<FormState>();
  final TextEditingController bookTypeController = TextEditingController();

  var isAllChanged = Rx<bool>(false);

  void editChangeDetect() {
    bool areFieldsNotEmpty = bookNameController.text.isNotEmpty &&
        bookAuthorController.text.isNotEmpty &&
        bookPageController.text.isNotEmpty;

    bool isAnyFieldChanged = bookNameController.text != okuurBookInfo!.name ||
        bookAuthorController.text != okuurBookInfo!.author ||
        bookPageController.text != okuurBookInfo!.pageCount.toString() ||
        bookTypeController.text != okuurBookInfo!.type;

    if (areFieldsNotEmpty && isAnyFieldChanged) {
      isAllChanged.value = true;
    } else {
      isAllChanged.value = false;
    }
  }

  Future<void> updateBookInfo() async {
    LoadingDialog.showLoading(message: "Kitap bilgileri güncelleniyor");
    OkuurBookInfo updatedBookInfo = okuurBookInfo!;
    try {
      if(bookNameController.text != okuurBookInfo!.name){
        updatedBookInfo.name = bookNameController.text;
      }
      if(bookAuthorController.text != okuurBookInfo!.author){
        updatedBookInfo.author = bookAuthorController.text;
      }
      if(bookPageController.text != okuurBookInfo!.pageCount.toString()){
        updatedBookInfo.pageCount = int.parse(bookPageController.text);
      }
      if(bookTypeController.text != okuurBookInfo!.type){
        updatedBookInfo.type = bookTypeController.text;
      }
      if(updatedBookInfo.pageCount <= updatedBookInfo.currentPage){
        updatedBookInfo.status += 1;
        updatedBookInfo.finishingDate = DateTime.now().toString();
      }else{
        if(updatedBookInfo.status != 0 && updatedBookInfo.status % 2 == 0){
          updatedBookInfo.status -= 1;
        }
      }
      await bookOperations.updateBookInfo(updatedBookInfo);
    } catch (e) {
      debugPrint("An error occurred: $e");
    } finally {
      LoadingDialog.hideLoading();
      setBookInfo(updatedBookInfo);
      getBookDetail();
      isLogChanged.value = true;
      Navigator.pop(Get.context!);
    }
  }

}