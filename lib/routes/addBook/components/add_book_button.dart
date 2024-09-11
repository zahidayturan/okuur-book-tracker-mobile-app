import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'dart:ui';

class AddBookButton extends StatefulWidget {
  const AddBookButton({Key? key,}) : super(key: key);

  @override
  State<AddBookButton> createState() => _AddBookButtonState();
}

class _AddBookButtonState extends State<AddBookButton> {
  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

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
            /*setState(() {
              bookNameValidate = OkuurValidator.basicValidate(_bookNameController.text);
              bookAuthorValidate = OkuurValidator.basicValidate(_bookAuthorController.text);
              bookPageValidate = OkuurValidator.basicValidate(_bookPageController.text);
              bookTypeValidate = OkuurValidator.compareValidate(_bookTypeController.text,bookTypeList.first);
            });
            if(bookNameValidate == true &&
                bookAuthorValidate == true &&
                bookPageValidate == true &&
                bookTypeValidate == true){
              var bookInfo = OkuurBookInfo(
                  name: _bookNameController.text,
                  author: _bookAuthorController.text,
                  pageCount: int.tryParse(_bookPageController.text)!,
                  imageLink: 'https://picsum.photos/250?image=8',
                  type: _bookTypeController.text,
                  startingDate:DateTime.now().toString(),
                  finishingDate: "finishingDate",
                  currentPage: 0,
                  readingTime: 0,
                  status: 0,
                  logIds:"1-");
              await bookOperations.insertBookInfo(bookInfo);
              Navigator.of(context).pop();
            }*/
          },
          child: Container(
            height: 36,
            decoration: BoxDecoration(
                color: colors.orange,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child:
                  text("Kitabı Ekle", colors.grey, 15, "FontMedium",1),
            )),
          ),
        ),
      ],
    );
  }
}