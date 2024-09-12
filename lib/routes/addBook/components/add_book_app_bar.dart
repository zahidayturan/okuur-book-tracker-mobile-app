import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/book_type_list.dart';

AppColors colors = AppColors();
final AddBookController controller = Get.find();
Row addBookAppBar(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      text("Yeni Kitap Ekle",colors.greenDark,18,"FontBold",3),
      InkWell(
        onTap: () {
          if(controller.bookNameController.text.isNotEmpty
              || controller.bookAuthorController.text.isNotEmpty
              || controller.bookPageController.text.isNotEmpty
              || controller.bookTypeController.text != bookTypeList.first){
            showDialog(
                context: Get.context!,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Uyarı",style: TextStyle(color: colors.red),textAlign: TextAlign.center,),
                    content: Text("Girdiğiniz bilgiler silinecektir.\nÇıkmak istiyor musunuz?",textAlign: TextAlign.center,),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))
                    ),
                    actions: [
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Expanded(
                                child: Container(
                                    height: 36,
                                    decoration: BoxDecoration(

                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(color: colors.blue,width: 1)
                                    ),
                                    child: Center(child: Text("Geri Dön",style: TextStyle(color: colors.blue),))),
                              )),
                          const SizedBox(height: 8),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Get.back();
                              },
                              child: Expanded(
                                child: Container(
                                    height: 36,
                                    decoration: BoxDecoration(
                                        color: colors.blue,
                                        borderRadius: const BorderRadius.all(Radius.circular(8))
                                    ),
                                    child: Center(child: Text("Çık",style: TextStyle(color: colors.white),))),
                              ))
                        ],
                      )
                    ],
                  );
                });
          }else {
            Get.back();
          }
        },
        highlightColor: colors.greenDark,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Container(
            height: 32,
            width: 32,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.greenDark,
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/icons/close.png",color: colors.white,)
        ),
      ),
    ],
  );
}