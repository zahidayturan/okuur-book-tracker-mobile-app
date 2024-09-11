import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBookController extends GetxController {
  var selectedImage = Rx<File?>(null);
  var bookName = Rx<String?>(null);
  var bookAuthor = Rx<String?>(null);
  var bookPageCount = RxInt(0);
  var bookType = Rx<String?>(null);
  var bookCurrentPage = RxInt(1);
  var bookCurrentStatus = RxInt(0);
  var bookInit = RxInt(0);

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

  void setBookPageCount(int pageCount) {
    bookPageCount.value = pageCount;
    if(bookCurrentPage.value > pageCount){
      setBookCurrentPage(pageCount != 0 ? pageCount : 1);
      textController.text = bookCurrentPage.toString();
    }
  }

  void clearBookPageCount() {
    bookPageCount.value = 0;
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

  void setBookInit(int init) {
    bookInit.value = init;
  }

  void clearBookInit() {
    bookInit.value = 0;
  }

  final TextEditingController textController = TextEditingController();
}

