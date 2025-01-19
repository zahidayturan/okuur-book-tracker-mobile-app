import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';

class AddLogController extends GetxController {

  var logBookId = Rx<String?>(null);
  void setLogBook(String id,int totalPage,int currentlyPage) {
    logBookId.value = id;
    bookPageCount.value = 3;
    bookCurrentlyPage.value = 1;
    bookPageCount.value = totalPage.toDouble();
    bookCurrentlyPage.value = currentlyPage.toDouble();
    sliderBookPageCount.value = (currentlyPage+1).toDouble();
    checkAllValidate();
  }
  void clearLogBook() {logBookId.value = null;}


  var logNewCurrentPage = Rx<int?>(null);
  void setLogNewCurrentPage(int page) {
    logNewCurrentPage.value = page;
    bookReadingPageCount.value = page - bookCurrentlyPage.value.toInt();
    setLogReadingTime((bookReadingPageCount.value*1.5).toInt());
    setLogReadingDate(DateTime.now());
    setLogFinishingHour("${DateTime.now().hour}:${DateTime.now().minute}");
    checkAllValidate();
  }
  void clearLogNewCurrentPage() {logNewCurrentPage.value = null;}
  final TextEditingController logNewCurrentPageController = TextEditingController();
  var bookPageCount = Rx<double>(3);
  var bookCurrentlyPage = Rx<double>(1);
  var sliderBookPageCount = Rx<double>(2);

  var logReadingTime = Rx<int?>(null);
  void setLogReadingTime(int minute) {logReadingTime.value = minute;}
  void clearLogReadingTime() {logReadingTime.value = null;}
  final TextEditingController logReadingTimeController = TextEditingController();
  var bookReadingPageCount = Rx<int>(1);

  var logReadingDate = Rx<String?>(null);
  void setLogReadingDate(DateTime date) {logReadingDate.value = date.toString();}
  void clearLogReadingDate() {logReadingDate.value = null;}
  final TextEditingController logReadingDateController = TextEditingController();

  var logFinishingHour = Rx<String?>(null);
  void setLogFinishingHour(String hour) {logFinishingHour.value = hour;}
  void clearLogFinishingHour() {logFinishingHour.value = null;}
  final TextEditingController logFinishingHourController = TextEditingController();


  void clearAll(){
    clearLogBook();
    clearLogNewCurrentPage();
    clearLogReadingTime();
    clearLogReadingDate();
    clearLogFinishingHour();

    logNewCurrentPageController.clear();
    logReadingTimeController.clear();
    logReadingDateController.clear();
    logFinishingHourController.clear();

    bookPageCount.value = 3;
    bookCurrentlyPage.value = 1;
    sliderBookPageCount.value = 2;
    bookReadingPageCount.value = 1;
  }


  var logAllValidate = RxBool(false);
  void setLogAllValidate(bool valid) {
    logAllValidate.value = valid;
  }
  void clearLogAllValidate() {
    logAllValidate.value = false;
  }
  void checkAllValidate(){
    if(logBookId.value != null
        && logNewCurrentPage.value != null
        && logReadingTime.value != null
        && logReadingDate.value != null
        && logFinishingHour.value != null
    ){
      setLogAllValidate(true);
    }else{
      setLogAllValidate(false);
    }
  }

  bool checkAllInfoIsNull(){
    if(logBookId.value == null
        && logNewCurrentPage.value == null
        && logReadingTime.value == null
        && logReadingDate.value == null
        && logFinishingHour.value == null
    ){
      return true;
    }else{
      return false;
    }
  }


  List<OkuurBookInfo> currentlyReadBooks = [];
  BookOperations bookOperations = BookOperations();
  var booksLoading = Rx<bool>(false);


  Future<void> fetchCurrentlyReadBooks() async {
    booksLoading.value = true;
    currentlyReadBooks = await bookOperations.getCurrentlyReadBooksInfo();
    currentlyReadBooks.sort((a, b) => a.startingDate.compareTo(b.startingDate));
    booksLoading.value = false;
  }
}

