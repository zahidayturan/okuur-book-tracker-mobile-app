import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/text_form_field.dart';
import '../../../ui/components/rich_text.dart';

class LogInfo extends StatefulWidget {
  const LogInfo({Key? key,}) : super(key: key);

  @override
  State<LogInfo> createState() => _LogInfoState();
}

class _LogInfoState extends State<LogInfo> {
  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

  final AddLogController controller = Get.find();

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
            texts: const ["Okuma ","Detayları"],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: const ["FontMedium","FontBold"],
          ),
          const SizedBox(height: 12,),
          Obx(() => form("Okunan\nEser","Kitabı Seçiniz",
              controller.logBookValidate.value,
              controller.logBookController,
              controller.logPageKey,(book)
              {
                controller.setLogBook(book);
                controller.setLogBookValidate(book.isNotEmpty ? true : false);
              },TextInputType.text),),
          const SizedBox(height: 12,),
        ],
      ),
    );
  }


  Widget form(String label,String hint,validate,controller,key,void Function(String)? onFieldSubmitted,keyboardType) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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


  Padding labelText(String label,bool validate) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 54,
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