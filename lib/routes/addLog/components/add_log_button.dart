import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/ui/components/loading_circular.dart';
import 'package:okuur/ui/components/regular_text.dart';

class AddLogButton extends StatefulWidget {
  const AddLogButton({Key? key}) : super(key: key);

  @override
  State<AddLogButton> createState() => _AddLogButtonState();
}

class _AddLogButtonState extends State<AddLogButton> {
  final AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();
  final AddLogController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return addButton();
  }

  Future<void> _handleAddLog(BuildContext context) async {
    if (!controller.logAllValidate.value) return;

    final logInfo = _createLogInfo();

    LoadingDialog.showLoading(message: "Kayıt ekleniyor");
    try {
      await LogOperations().insertLogInfo(logInfo);
      await bookOperations.updateBookInfoAfterLog(logInfo,0,null);
      await homeController.fetchCurrentlyReadBooks(true);
      await homeController.fetchLogForDate(true);
      await homeController.fetchSeries(true);
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    } finally {
      LoadingDialog.hideLoading();
      Navigator.of(context).pop();
    }
  }

  OkuurLogInfo _createLogInfo() {
    return OkuurLogInfo(
      bookId: controller.logBookId.value!,
      numberOfPages: controller.bookReadingPageCount.value,
      timeRead: controller.logReadingTime.value!,
      readingDate: controller.logReadingDate.value!,
      finishingTime: controller.logFinishingHour.value!,
    );
  }

  Widget addButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _handleAddLog(context),
            child: Obx(
                  () => Container(
                decoration: BoxDecoration(
                  color: controller.logAllValidate.value
                      ? colors.blueMid
                      : Theme.of(context).buttonTheme.colorScheme?.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    child: RegularText(texts:  controller.logAllValidate.value
                        ? "Okumayı Kaydet"
                        : "Tüm Bilgileri Doldurun",color: colors.white,size: "l"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
