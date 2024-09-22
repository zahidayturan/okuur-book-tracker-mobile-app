import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLogController extends GetxController {

  var logBook = Rx<String?>(null);
  final logPageKey = GlobalKey<FormState>();
  final TextEditingController logBookController = TextEditingController();
  var logBookValidate = RxBool(true);
  void setLogBook(String name) {
    logBook.value = name;
  }
  void clearLogBook() {
    logBook.value = null;
  }
  void setLogBookValidate(bool valid) {
    logBookValidate.value = valid;
  }
  void clearLogBookValidate() {
    logBookValidate.value = true;
  }




  var logPage = RxInt(0);
  var logTime = RxInt(1);
  var logDate = RxInt(0);





  void clearAll(){
  clearLogBook();
  clearLogBookValidate();
  }

}

