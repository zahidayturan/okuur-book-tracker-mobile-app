import 'package:get/get.dart';

class AddLogController extends GetxController {

  var logBookId = Rx<int?>(null);
  void setLogBook(int id) {logBookId.value = id;}
  void clearLogBook() {logBookId.value = null;}


  var logNewCurrentPage = Rx<int?>(null);
  void setLogPage(int page) {logNewCurrentPage.value = page;}
  void clearLogPage() {logNewCurrentPage.value = null;}

  var logReadingTime = Rx<int?>(null);
  void setLogReadingTime(int minute) {logReadingTime.value = minute;}
  void clearLogReadingTime() {logReadingTime.value = null;}

  var logReadingDate = Rx<String?>(null);
  void setLogReadingDate(String date) {logReadingDate.value = date;}
  void clearLogReadingDate() {logReadingDate.value = null;}

  var logStartingHour = Rx<String?>(null);
  void setLogStartingHour(String date) {logStartingHour.value = date;}
  void clearLogStartingHour() {logStartingHour.value = null;}


  void clearAll(){
    clearLogBook();
    clearLogPage();
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

