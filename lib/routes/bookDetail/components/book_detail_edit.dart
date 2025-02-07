import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';
import 'package:okuur/ui/components/functional_alert_dialog.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/text_form_field.dart';
import 'package:okuur/ui/const/book_type_list.dart';

AppColors colors = AppColors();
BookDetailController controller = Get.find();


void showBookDetailEditDialog(BuildContext context,OkuurBookInfo okuurBookInfo) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    popButton(context,false),
                    const RegularText(texts: "Kitap Bilgilerini Düzenle",size: "xl",)
                  ],
                ),
                const SizedBox(height: 12),
                form(context, "Kitabın Adı", "Adını yazınız",
                    controller.bookNameController.text.isNotEmpty,
                    controller.bookNameController, controller.bookNameKey,
                    (name) {
                      controller.editChangeDetect();
                    },
                    TextInputType.text),
                const SizedBox(height: 12,),
                form(context,"Kitabın Yazarı","Yazarını yazınız",
                    controller.bookAuthorController.text.isNotEmpty,
                    controller.bookAuthorController, controller.bookAuthorKey,
                        (author) {
                      controller.editChangeDetect();
                    },
                    TextInputType.text),
                const SizedBox(height: 12,),
                form(context,"Sayfa Sayısı","Sayfa sayısını yazınız",
                    (int.tryParse(controller.bookPageController.text) != 0 && controller.bookPageController.text.isNotEmpty),
                    controller.bookPageController, controller.bookPageKey,
                        (page) {
                      controller.editChangeDetect();
                    },
                    TextInputType.number),
                const SizedBox(height: 12,),
                typeForm(context),
                const SizedBox(height: 12,),
                addButton(context, okuurBookInfo)
              ],
            ),
          ),
        ),
      );},
  );
}

Widget form(BuildContext context,String label,String hint,validate,controller,key,void Function(String)? onFieldSubmitted,keyboardType) {
  return OkuurTextFormField(
      hint: hint,
      controller: controller,
      key: key,
      label: label,
      labelColor: validate == true ? colors.blue : colors.red,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted
  ).getTextFormFieldForPage(context);
}

Widget typeForm(BuildContext context) {
  bookTypeList.remove("Türünü seçiniz");
  List<String> updatedBookTypeList = List.from(bookTypeList);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      labelText("Kitabın Türü", true),
      Row(
        children: [
          SizedBox(
            height: 32,
            child: OkuurDropdownMenu(
              controller: controller.bookTypeController,
              key: controller.bookTypeKey,
              list: updatedBookTypeList,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              textColor: Theme.of(context).colorScheme.secondary,
              padding: 0,
              fontSize: 14,
              initialIndex: bookTypeList.indexWhere((element) => element == controller.bookTypeController.text),
              onChanged: (value) {
                controller.editChangeDetect();
              },
            ),
          ),
        ],
      ),
    ],
  );
}

RegularText labelText(String label,bool validate) {
  return RegularText(texts:
  label,
    align: TextAlign.end,
    size: "s",
    maxLines: 2,
    color: validate == true ? colors.blue : colors.red,
  );
}

Widget addButton(BuildContext context,OkuurBookInfo okuurBookInfo) {
  return Obx(() => Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () async {
            if(controller.isAllChanged.value){
              if(int.parse(controller.bookPageController.text) > okuurBookInfo.currentPage){
                controller.updateBookInfo();
              }else{
                bool shouldExit = await _showCustomDialog("Yeni sayfa sayısını okumakta olduğunuz sayfa sayısından küçük girdiniz. İşleme devam etmeniz durumunda kitabı bitirmiş sayılacaksınız.\nOnaylıyor musunuz?",context);
                if (shouldExit) {
                  controller.updateBookInfo();
                }
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: controller.isAllChanged.value ? colors.blue : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RegularText(
                    texts: controller.isAllChanged.value ? "Değişiklikleri Kaydet" : "Bilgileri Düzenleyin",
                    color: controller.isAllChanged.value ? colors.grey : colors.greyMid,size: "l"),
              ),
            ),
          ),
        ),
      ),
    ],
  ));
}

Future<bool> _showCustomDialog(String text,BuildContext context) async {
  bool? result = await OkuurAlertDialog.show(
    context: context,
    contentText: text,
    buttons: [
      AlertButton(text: "Geri Dön", fill: false, returnValue: false),
      AlertButton(text: "Devam Et", fill: true, returnValue: true),
    ],
  );
  return result ?? false;
}