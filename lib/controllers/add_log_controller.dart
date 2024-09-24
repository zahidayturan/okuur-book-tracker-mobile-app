import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddLogController extends GetxController {

  var logBookId = Rx<int?>(null);
  void setLogBook(int id) {logBookId.value = id;}
  void clearLogBook() {logBookId.value = null;}


  var logNewCurrentPage = Rx<int?>(null);
  void setLogNewCurrentPage(int page) {
    logNewCurrentPage.value = page;
    setLogReadingTime(63);
    setLogReadingDate(DateFormat('dd.MM.yyyy').format(DateTime.now()).toString());
    setLogStartingHour("${DateTime.now().hour}:${DateTime.now().minute}");
    checkAllValidate();
  }

  void clearLogNewCurrentPage() {logNewCurrentPage.value = null;}

  var logReadingTime = Rx<int?>(null);
  void setLogReadingTime(int minute) {logReadingTime.value = minute;}
  void clearLogReadingTime() {logReadingTime.value = null;}
  final TextEditingController logReadingTimeController = TextEditingController();

  var logReadingDate = Rx<String?>(null);
  void setLogReadingDate(String date) {logReadingDate.value = date;}
  void clearLogReadingDate() {logReadingDate.value = null;}
  final TextEditingController logReadingDateController = TextEditingController();
  final logReadingDateKey = GlobalKey<FormState>();

  var logStartingHour = Rx<String?>(null);
  void setLogStartingHour(String hour) {logStartingHour.value = hour;}
  void clearLogStartingHour() {logStartingHour.value = null;}


  void clearAll(){
    clearLogBook();
    clearLogNewCurrentPage();
    clearLogReadingTime();
    clearLogReadingDate();
    clearLogStartingHour();
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

}

