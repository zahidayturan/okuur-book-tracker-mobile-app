import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/ui/components/loading_circular.dart';

class BookDetailController extends GetxController {

  BookOperations bookOperations = BookOperations();
  LogOperations logOperations = LogOperations();

  OkuurBookInfo? okuurBookInfo;
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
      await bookOperations.updateBookInfoAfterLog(okuurLogInfo,1,null);
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
  BOOK EDIT
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

  /*
  UPDATE
   */

  Future<void> updateBookStatus(OkuurBookInfo bookInfo,bool firstReading) async {
    LoadingDialog.showLoading(message: "Kitap durumu güncelleniyor");
    try {
      OkuurBookInfo updatedBookInfo = bookInfo;
      if(!firstReading){ // tekrar okumaya başladı
        updatedBookInfo.currentPage = 0;
        updatedBookInfo.finishingDate = "finishingDate";
      }
      updatedBookInfo.startingDate = DateTime.now().toString();
      updatedBookInfo.status = updatedBookInfo.status + 1;
      await bookOperations.updateBookInfo(updatedBookInfo);
    } catch (e) {
      debugPrint("An error occurred: $e");
    } finally {
      LoadingDialog.hideLoading();
      isLogChanged.value = true;
      Navigator.pop(Get.context!, true);
    }
  }

  /*
  RECORD EDIT
   */

  var isAllChangedRecordEdit = Rx<bool>(false);

  void editRecordInit(OkuurLogInfo okuurLogInfo,OkuurBookInfo bookInfo) {
    logNewCurrentPageController.text = okuurLogInfo.numberOfPages.toString();
    bookOldLogPageCount.value = okuurLogInfo.numberOfPages;
    isAllChangedRecordEdit.value = false;
  }

  var bookOldLogPageCount = Rx<int>(1);
  final TextEditingController logNewCurrentPageController = TextEditingController();

  void setLogNewLogPage(int page) {
    if(page != bookOldLogPageCount.value){
      isAllChangedRecordEdit.value = true;
    }else{
      isAllChangedRecordEdit.value = false;
    }
    logNewCurrentPageController.text = page.toString();
  }

  Future<void> updateLogInfo(OkuurLogInfo logInfo) async {
    LoadingDialog.showLoading(message: "Okuma kaydı güncelleniyor");
    try {
      int newLogPageCount = int.parse(logNewCurrentPageController.text);
      double timePageRate = logInfo.timeRead / logInfo.numberOfPages;

      OkuurLogInfo updatedLogInfo = logInfo.copyWith(
        numberOfPages: newLogPageCount,
        timeRead: (newLogPageCount * timePageRate).toInt(),
      );

      bool status = await logOperations.updateLogInfo(updatedLogInfo);
      if (!status) {
        throw Exception("Okuma kaydı güncellenirken bir hata oluştu.");
      }

      okuurBookInfo = await bookOperations.updateBookInfoAfterLog(logInfo, 2, updatedLogInfo);
    } catch (e) {
      debugPrint("updateLogInfo hata: $e");
    } finally {
      LoadingDialog.hideLoading();
      setBookInfo(okuurBookInfo);
      getBookDetail();
      isLogChanged.value = true;
      Navigator.pop(Get.context!);
    }
  }

  /*
  POINTS
   */

  var bookRating = RxDouble(0.0);
  final TextEditingController textControllerForSlider = TextEditingController(text: "1");

  void setBookRating(double rate) {
    bookRating.value = rate;
  }

  Future<void> updateBookPoint(OkuurBookInfo bookInfo) async {
    if(bookInfo.rating != bookRating.value){
      LoadingDialog.showLoading(message: "Kitap puanı güncelleniyor");
      try {
        if(bookRating.value > 5){
          bookRating.value = bookRating.value/20;
        }
        bookInfo.rating = bookRating.value;
        await bookOperations.updateBookInfo(bookInfo);
      } catch (e) {
        debugPrint("An error occurred, point update: $e");
      } finally {
        LoadingDialog.hideLoading();
        setBookInfo(bookInfo);
        getBookDetail();
        isLogChanged.value = true;
        Navigator.pop(Get.context!, true);
      }
    }
  }

}