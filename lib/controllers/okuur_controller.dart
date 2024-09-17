import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okuur/core/theme/theme_colors.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';

class OkuurController extends GetxController {

  var homePageCurrentMode = RxInt(0);

  void setHomePageCurrentMode(int pageCount) {
    homePageCurrentMode.value = pageCount;
  }

  void clearHomePageCurrentMode() {
    homePageCurrentMode.value = 0;
  }



  final OkuurLocalStorage storage = OkuurLocalStorage();

  void switchTheme(int value,bool systemIsDark) {
    storage.saveTheme(value);
    if(value == 0){
      Get.changeThemeMode(ThemeMode.light);
      setSystemNavBarColor(false);
    }else if(value == 1){
      Get.changeThemeMode(ThemeMode.dark);
      setSystemNavBarColor(true);
    }else{
      Get.changeThemeMode(ThemeMode.system);
      setSystemNavBarColor(systemIsDark);
    }

  }


  ThemeMode getTheme(int value){
    if(value == 0){
      return ThemeMode.light;
    }else if(value == 1){
      return ThemeMode.dark;
    }else{
      return ThemeMode.system;
    }
  }

  void setSystemNavBarColor(bool isDark){
    print(isDark);
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: storage.getTheme() == 1 ? const Color(0xFF0E0E0E)  : isDark ?   const Color(0xFF0E0E0E) : Colors.white,
          )
      );
  }

}