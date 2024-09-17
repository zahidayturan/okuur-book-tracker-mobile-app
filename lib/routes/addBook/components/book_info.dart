import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';
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
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
              texts: const ["Kitabın ","Bilgilerini ","Giriniz"],
              colors: [Theme.of(context).colorScheme.secondary],
              fontFamilies: const ["FontMedium","FontBold","FontMedium"],
             ),
          const SizedBox(height: 12,),
          Obx(() => form("Kitabın\nAdı","Adını yazınız",controller.bookNameValidate.value,controller.bookNameController,controller.bookNameKey,(name) {
            controller.setBookName(name);
            controller.setBookNameValidate(name.isNotEmpty ? true : false);
          },TextInputType.text),),
          const SizedBox(height: 12,),
          Obx(() => form("Kitabın\nYazarı","Yazarını yazınız",controller.bookAuthorValidate.value,controller.bookAuthorController,controller.bookAuthorKey,(author) {
            controller.setBookAuthor(author);
            controller.setBookAuthorValidate(author.isNotEmpty ? true : false);
          },TextInputType.text),),
          const SizedBox(height: 12,),
          Obx(() => form("Sayfa\nSayısı","Sayfa sayısını yazınız",controller.bookPageValidate.value,controller.bookPageController,controller.bookPageKey,(page) {
            controller.setBookPageCount(int.parse(page));
            controller.setBookPageValidate(int.parse(page) != 0 ? true : false);
          },TextInputType.number),),
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
          ).getTextFormFieldForPage(context),
        ),
      ],
    );
  }



  Widget typeForm() {
    return Obx(() => Row(
      children: [
        labelText("Kitabın\nTürü",controller.bookTypeValidate.value),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            child: OkuurDropdownMenu(
              controller: controller.bookTypeController,
              key: controller.bookTypeKey,
              list: bookTypeList,
              dropdownColor: Theme.of(context).colorScheme.onPrimaryContainer,
              textColor: Theme.of(context).colorScheme.secondary,
              padding: 0,
              fontSize: 14,
              initialIndex: 0,
              onChanged: (value) {
                controller.setBookType(value);
                controller.setBookTypeValidate(value != bookTypeList.first ? true : false);
              },
            ),
          ),
        ),
      ],
    ));
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