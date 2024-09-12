import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/alert_dialog.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/book_type_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return  addButton();
  }

  Widget addButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            setState(() {
              controller.setBookNameValidate(OkuurValidator.basicValidate(controller.bookNameController.text));
              controller.setBookAuthorValidate(OkuurValidator.basicValidate(controller.bookAuthorController.text));
              controller.setBookPageValidate(OkuurValidator.basicValidate(controller.bookPageController.text));
              controller.setBookPageValidate(OkuurValidator.rangeValidate(double.parse(controller.bookPageController.text),1,10000));
              controller.setBookTypeValidate(OkuurValidator.compareValidate(controller.bookTypeController.text,bookTypeList.first));
            });
            if(controller.bookNameValidate.value == true &&
                controller.bookAuthorValidate.value == true &&
                controller.bookPageValidate.value == true &&
                controller.bookTypeValidate.value == true){
              var bookInfo = OkuurBookInfo(
                  name: controller.bookNameController.text,
                  author: controller.bookAuthorController.text,
                  pageCount: int.tryParse(controller.bookPageController.text)!,
                  imageLink: 'https://picsum.photos/250?image=8',
                  type: controller.bookTypeController.text,
                  startingDate:DateTime.now().toString(),
                  finishingDate: "finishingDate",
                  currentPage: 0,
                  readingTime: 0,
                  status: 0,
                  logIds:"1-");
              //await bookOperations.insertBookInfo(bookInfo);
              Navigator.of(context).pop();
            } else {
              if(OkuurValidator.rangeValidate(double.parse(controller.bookPageController.text),1,9999) == false){
                showAlert("Uyarı","Kitabın sayfa sayısı 0'dan büyük ve 10000'den küçük olmalıdır");
              }else {
                showAlert("Uyarı","Lütfen kitabın bilgilerini\neksiksiz ve doğru giriniz.");
              }
            }
          },
          child: Container(
            height: 42,
            decoration: BoxDecoration(
                color: colors.orange,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child:
                  text("Kitabı Ekle", colors.white, 15, "FontMedium",1),
            )),
          ),
        ),
      ],
    );
  }
}