import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/ui/components/functional_alert_dialog.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/text_form_field.dart';

AppColors colors = AppColors();
BookDetailController controller = Get.find();

void showBookRecordEditDialog(BuildContext context,OkuurLogInfo okuurLogInfo, OkuurBookInfo okuurBookInfo) {
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

                const SizedBox(height: 12),
                addButton(context, okuurLogInfo)
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
                //bool shouldExit = await _showCustomDialog("Uyarı",context);
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