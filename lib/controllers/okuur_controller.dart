import 'package:get/get.dart';

class OkuurController extends GetxController {

  var homePageCurrentMode = RxInt(0);

  void setHomePageCurrentMode(int pageCount) {
    homePageCurrentMode.value = pageCount;
  }

  void clearHomePageCurrentMode() {
    homePageCurrentMode.value = 0;
  }

}