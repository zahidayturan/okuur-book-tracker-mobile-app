import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/text_form_field.dart';

AppColors colors = AppColors();
BookDetailController controller = Get.find();

void showBookRecordEditDialog(BuildContext context,OkuurLogInfo logInfo, OkuurBookInfo bookInfo) {
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
                    const RegularText(texts: "Okuma Kaydını Düzenle",size: "xl",)
                  ],
                ),
                const SizedBox(height: 12),
                RegularText(texts: "En fazla ${bookInfo.pageCount-(bookInfo.currentPage-logInfo.numberOfPages)} değerini girebilirsiniz.",size: "m",maxLines: 4),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RegularText(texts: "Okunan Sayfa Sayısı",maxLines: 2),
                    SizedBox(
                      height: 20,
                      width: 50,
                      child: TextFormField(
                          controller: controller.logNewCurrentPageController,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: (controller.bookOldLogPageCount.value).toStringAsFixed(0),
                            counterText: "",
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            contentPadding: const EdgeInsets.only(bottom: 12),
                            border: const UnderlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontFamily: "FontBold"
                          ),
                          onFieldSubmitted: (value) {
                            _handleInputValidation(value,bookInfo,logInfo);
                          },
                          onTapOutside: (event) {
                            if(FocusScope.of(context).hasFocus){
                              _handleInputValidation(controller.logNewCurrentPageController.text,bookInfo,logInfo);
                              FocusScope.of(context).unfocus();
                            }
                          }
                      ),
                    )
                  ],
                ),
                Visibility(
                    visible: controller.isAllChangedRecordEdit.value,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Center(child: RegularText(texts: "Yeni sayfa ${(int.parse(controller.logNewCurrentPageController.text))+bookInfo.currentPage-logInfo.numberOfPages} olacaktır",size: "m",maxLines: 4)),
                    )),
                const SizedBox(height: 12),
                addButton(context, logInfo)
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

RegularText labelText(String label,bool validate) {
  return RegularText(texts:
  label,
    align: TextAlign.end,
    size: "s",
    maxLines: 2,
    color: validate == true ? colors.blue : colors.red,
  );
}

Widget addButton(BuildContext context,OkuurLogInfo okuurLogInfo) {
  return Obx(() => Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () async {
            if(controller.isAllChangedRecordEdit.value){
              await controller.updateLogInfo(okuurLogInfo);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: controller.isAllChangedRecordEdit.value ? colors.blue : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RegularText(
                    texts: controller.isAllChangedRecordEdit.value ? "Değişiklikleri Kaydet" : "Bilgileri Düzenleyin",
                    color: controller.isAllChangedRecordEdit.value ? colors.grey : colors.greyMid,size: "l"),
              ),
            ),
          ),
        ),
      ),
    ],
  ));
}

void _handleInputValidation(String value,OkuurBookInfo bookInfo, OkuurLogInfo logInfo) {
  if (value.isNotEmpty && (int.parse(value) > 0) &&
      (int.parse(value)+bookInfo.currentPage-logInfo.numberOfPages <= bookInfo.pageCount)) {
    controller.setLogNewLogPage(int.parse(value));
  } else {
    controller.setLogNewLogPage((controller.bookOldLogPageCount.value).toInt());
  }
}