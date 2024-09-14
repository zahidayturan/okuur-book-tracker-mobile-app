import 'package:get/get.dart';

class LibraryController extends GetxController {

  var pageCurrentMode = RxInt(0);

  void setPageCurrentMode(int pageCount) {
    pageCurrentMode.value = pageCount;
  }

  void clearPageCurrentMode() {
    pageCurrentMode.value = 0;
  }

}