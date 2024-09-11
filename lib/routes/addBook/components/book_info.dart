import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';
import 'dart:ui';
import 'package:okuur/ui/components/text_form_field.dart';
import 'package:okuur/ui/const/book_type_list.dart';
import '../../../ui/components/rich_text.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({Key? key,}) : super(key: key);

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

  final AddBookController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        formContent(),
      ],
    );
  }

  Widget formContent() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
              texts: ["Kitabın ","Bilgilerini ","Giriniz"],
              colors: [colors.black,colors.black,colors.black],
              fontFamilies: ["FontMedium","FontBold","FontMedium"],
              fontSize: 15,
              align: TextAlign.start),
          const SizedBox(height: 12,),
          form("Kitabın\nAdı","Adını yazınız",bookNameValidate,_bookNameController,_bookNameKey,(name) {
            controller.setBookName(name);
          },TextInputType.text),
          const SizedBox(height: 12,),
          form("Kitabın\nYazarı","Yazarını yazınız",bookAuthorValidate,_bookAuthorController,_bookAuthorKey,(author) {
            controller.setBookAuthor(author);
          },TextInputType.text),
          const SizedBox(height: 12,),
          form("Sayfa\nSayısı","Sayfa sayısını yazınız",bookPageValidate,_bookPageController,_bookPageKey,(page) {
            controller.setBookPageCount(int.parse(page));
          },TextInputType.number),
          const SizedBox(height: 12,),
          typeForm(),
          const SizedBox(height: 12,),
        ],
      ),
    );
  }
  Widget form(String label,String hint,validate,controller,key,void Function(String)? onFieldSubmitted,keyboardType) {
    return Row(
      children: [
        labelText(label,validate),
        Expanded(
          child: OkuurTextFormField(
              hint: hint,
              controller: controller,
              key: key,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted
          ).getTextFormFieldForPage(),
        ),
      ],
    );
  }

  final _bookNameKey = GlobalKey<FormState>();
  final TextEditingController _bookNameController = TextEditingController();
  bool bookNameValidate = true;


  final _bookAuthorKey = GlobalKey<FormState>();
  final TextEditingController _bookAuthorController = TextEditingController();
  bool bookAuthorValidate = true;


  final _bookPageKey = GlobalKey<FormState>();
  final TextEditingController _bookPageController = TextEditingController();
  bool bookPageValidate = true;


  final _bookTypeKey = GlobalKey<FormState>();
  final TextEditingController _bookTypeController = TextEditingController();
  bool bookTypeValidate = true;

  Widget typeForm() {
    return Row(
      children: [
        labelText("Kitabın\nTürü",bookTypeValidate),
        OkuurDropdownMenu(
            controller: _bookTypeController,
            key: _bookTypeKey,
          list: bookTypeList,
          dropdownColor: colors.white,
          textColor: colors.black,
          padding: 0,
          fontSize: 14,
          onChanged: (value) {
            controller.setBookType(value);
          },
        ),
      ],
    );
  }

  Padding labelText(String label,bool validate) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 48,
        child: Text(
          label,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
            color: validate == true ? colors.blue : colors.red,
          ),
        ),
      ),
    );
  }
}