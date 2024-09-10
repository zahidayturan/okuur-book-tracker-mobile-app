import 'dart:io';
import 'package:get/get.dart';

class AddBookController extends GetxController {
  var selectedImage = Rx<File?>(null);

  void setImage(File? image) {
    selectedImage.value = image;
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
