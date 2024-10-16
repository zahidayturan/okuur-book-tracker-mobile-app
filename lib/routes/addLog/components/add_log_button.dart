import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/ui/components/regular_text.dart';

class AddLogButton extends StatefulWidget {
  const AddLogButton({Key? key,}) : super(key: key);

  @override
  State<AddLogButton> createState() => _AddLogButtonState();
}

class _AddLogButtonState extends State<AddLogButton> {
  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

  final AddLogController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  addButton();
  }

  Widget addButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              if(controller.logAllValidate.value){
                var logInfo = OkuurLogInfo(
                    bookId: controller.logBookId.value!,
                    numberOfPages: controller.logNewCurrentPage.value!,
                    timeRead: controller.logReadingTime.value!,
                    readingDate: controller.logReadingDate.value!,
                    finishingTime: controller.logFinishingHour.value!);
                await LogOperations().insertLogInfo(logInfo);
                await BookOperations().updateBookInfoAfterLog(logInfo);
                Navigator.of(context).pop();
              }
            },
            child: Obx(() => Container(
              decoration: BoxDecoration(
                  color: controller.logAllValidate.value ? colors.blueMid : Theme.of(context).buttonTheme.colorScheme?.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 14),
                    child:
                    text( controller.logAllValidate.value ? "Okumayı Kaydet" : "Tüm Bilgileri Doldurun", colors.white, 15, "FontMedium",1),
                  )),
            ),)
          ),
        ),
      ],
    );
  }
}