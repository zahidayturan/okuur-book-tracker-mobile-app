import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OkuurDeviceUtils{

  static void hideKeyboard(){
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async{
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color)
    );
  }

    static bool isLandscopeOrientation(){
      final viewInsets = View.of(Get.context!).viewInsets;
      return viewInsets.bottom == 0;
    }

    static bool isPortraitOrientation(){
      final viewInsets = View.of(Get.context!).viewInsets;
      return viewInsets.bottom != 0;
    }

    static void setFullScreen(bool enable){
      SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
    }
    
    static double getScreenHeight(){
      return MediaQuery.of(Get.context!).size.height;
    }

    static double getScreenWidth(){
      return MediaQuery.of(Get.context!).size.width;
    }

    static double getPixelRatio(){
      return MediaQuery.of(Get.context!).devicePixelRatio;
    }

    static double getStatusBarHeight(){
      return MediaQuery.of(Get.context!).padding.top;
    }

  static double getKeyboardHeight(){
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible() async {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom > 0;
  }

  static void hideStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
  }

  static void showStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  }

  static Future<bool> hasInternetConnection() async {
    try{
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    }on SocketException catch (_){
      return false;
    }
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static void launchUrl(String url) async {
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else {
      throw "Could not launch $url";
    }
  }


}