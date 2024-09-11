import 'dart:ffi';
import 'dart:io';
import 'package:get/get.dart';

class AddBookController extends GetxController {
  var selectedImage = Rx<File?>(null);
  var bookName = Rx<String?>(null);
  var bookAuthor = Rx<String?>(null);
  var bookPageCount = Rx<Int?>(null);
  var bookType = Rx<String?>(null);
  var bookCurrentPage = RxInt(1);
  var bookCurrentStatus = RxInt(0);

  void setImage(File? image) {
    selectedImage.value = image;
  }

  void clearImage() {
    selectedImage.value = null;
  }

  void setBookName(String name) {
    bookName.value = name;
  }

  void clearBookName() {
    bookName.value = null;
  }

  void setBookAuthor(String author) {
    bookAuthor.value = author;
  }

  void clearBookAuthor() {
    bookAuthor.value = null;
  }

  void setBookPageCount(Int pageCount) {
    bookPageCount.value = pageCount;
  }

  void clearBookPageCount() {
    bookPageCount.value = null;
  }

  void setBookType(String type) {
    bookType.value = type;
  }

  void clearBookType() {
    bookType.value = null;
  }

  void setBookCurrentPage(int currentPage) {
    bookCurrentPage.value = currentPage;
  }

  void clearBookCurrentPage() {
    bookCurrentPage.value = 1;
  }

  void setBookCurrentStatus(int currentStatus) {
    bookCurrentStatus.value = currentStatus;
  }

  void clearBookCurrentStatus() {
    bookCurrentStatus.value = 0;
  }
}

