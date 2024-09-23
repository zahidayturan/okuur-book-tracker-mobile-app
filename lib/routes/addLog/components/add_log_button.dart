import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
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
        InkWell(
          onTap: () {

          },
          child: Obx(() => Container(
            height: 42,
            decoration: BoxDecoration(
                color: controller.logAllValidate.value ? colors.blueMid : colors.blueLight,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child:
                  text("Okumayı Kaydet", colors.white, 15, "FontMedium",1),
                )),
          ),)
        ),
      ],
    );
  }
}