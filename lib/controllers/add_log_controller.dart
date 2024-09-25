import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';

class AddLogController extends GetxController {

  var logBookId = Rx<int?>(null);
  void setLogBook(int id,int totalPage,int currentlyPage) {
    logBookId.value = id;
    bookPageCount.value = 3;
    bookCurrentlyPage.value = 1;
    sliderBookPageCount.value = 2;
    bookPageCount.value = totalPage.toDouble();
    bookCurrentlyPage.value = currentlyPage.toDouble();
    sliderBookPageCount.value = (currentlyPage+1).toDouble();
  }
  void clearLogBook() {logBookId.value = null;}


  var logNewCurrentPage = Rx<int?>(null);
  void setLogNewCurrentPage(int page) {
    logNewCurrentPage.value = page;
    bookReadingPageCount.value = page - bookCurrentlyPage.value.toInt();
    setLogReadingTime(63);
    setLogReadingDate(DateFormat('dd.MM.yyyy').format(DateTime.now()).toString());
    setLogStartingHour("${DateTime.now().hour}:${DateTime.now().minute}");
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
  void setLogReadingDate(String date) {logReadingDate.value = date;}
  void clearLogReadingDate() {logReadingDate.value = null;}
  final TextEditingController logReadingDateController = TextEditingController();

  var logStartingHour = Rx<String?>(null);
  void setLogStartingHour(String hour) {logStartingHour.value = hour;}
  void clearLogStartingHour() {logStartingHour.value = null;}
  final TextEditingController logStartingHourController = TextEditingController();


  void clearAll(){
    clearLogBook();
    clearLogNewCurrentPage();
    clearLogReadingTime();
    clearLogReadingDate();
    clearLogStartingHour();

    logNewCurrentPageController.clear();
    logReadingTimeController.clear();
    logReadingDateController.clear();
    logStartingHourController.clear();

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
        && logStartingHour.value != null
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
        && logStartingHour.value == null
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
    booksLoading.value = false;
  }
}

