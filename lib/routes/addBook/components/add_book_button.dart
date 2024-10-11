import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/controllers/library_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/alert_dialog.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/book_type_list.dart';
import 'package:okuur/ui/utils/simple_calc.dart';

import 'package:okuur/ui/utils/validator.dart';

class AddBookButton extends StatefulWidget {
  const AddBookButton({Key? key,}) : super(key: key);

  @override
  State<AddBookButton> createState() => _AddBookButtonState();
}

class _AddBookButtonState extends State<AddBookButton> {
  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

  final AddBookController controller = Get.find();
  final LibraryController libraryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return  addButton();
  }

  Widget addButton() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              setState(() {
                controller.checkAllValidate();
              });
              if(controller.bookAllValidate.value){
                String tempStartingDate = "startingDate";
                String tempFinishingDate = "finishingDate";
                int tempCurrentPage = 0;
                int tempStatus = 1;
                int tempReadingTime = 0;
                double tempRating = 0;
                String imageLink = "none";

                  if(controller.bookCurrentStatus.value != 2){
                    if(controller.bookInit.value == 0){
                      tempStartingDate = DateTime.now().toString();
                    }
                    if(controller.bookCurrentStatus.value == 1){
                      tempCurrentPage = controller.bookCurrentPage.value;
                    }
                    tempStatus = controller.bookInit.value == 0 ? 1 : 0;
                  }else{
                    tempStartingDate = DateFormat('dd.MM.yyyy').parse(controller.bookStartedDateController.text).toString();
                    tempFinishingDate = DateFormat('dd.MM.yyyy').parse(controller.bookFinishedDateController.text).toString();
                    tempCurrentPage = int.tryParse(controller.bookPageController.text)!;
                    tempStatus = 2;
                    tempReadingTime = (int.tryParse(controller.bookPageController.text)! *1.5).toInt();
                    tempRating = controller.bookRating.value;
                  }

                var bookInfo = OkuurBookInfo(
                    name: controller.bookNameController.text,
                    author: controller.bookAuthorController.text,
                    pageCount: int.tryParse(controller.bookPageController.text)!,
                    imageLink: imageLink,
                    type: controller.bookTypeController.text,
                    startingDate: tempStartingDate,
                    finishingDate: tempFinishingDate,
                    currentPage: tempCurrentPage,
                    readingTime: tempReadingTime,
                    status: tempStatus,
                    logIds:"",
                    rating: tempRating
                );
                await bookOperations.insertBookInfo(bookInfo);
                await libraryController.fetchBooks();
                Navigator.of(context).pop();
              } else {
                if(OkuurValidator.rangeValidate(double.tryParse(controller.bookPageController.text),1,9999) == false){
                  showAlert("Uyarı","Kitabın sayfa sayısı 0'dan büyük ve 10000'den küçük olmalıdır");
                }else {
                  showAlert("Uyarı","Lütfen kitabın bilgilerini\neksiksiz ve doğru giriniz.");
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: colors.orange,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 14),
                child:
                    text("Kitabı Ekle", colors.white, 15, "FontMedium",1),
              )),
            ),
          ),
        ),
      ],
    );
  }
}