import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/image_picker.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';

AppColors colors = AppColors();

Container addBookImage(BuildContext context) {
  final AddBookController controller = Get.find();

  Future<void> pickImage() async {
    try {
      final pickerService = OkuurImagePicker(context: Get.context!);
      final File? selectedImage = await pickerService.pickImageFromCamera();

      if (selectedImage != null) {
        controller.setImage(selectedImage); // Update the image in the controller
      }
    } catch (e) {
      debugPrint("Image picking failed: $e");
    }
  }

  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTextWidget(
                  texts: const ["Kitabın ","Kapak Fotoğrafı"],
                  colors: [Theme.of(context).colorScheme.secondary],
                  fontFamilies: const ["FontMedium","FontBold"],),
              const SizedBox(height: 4),
              const RegularText(texts: "İsterseniz kapak fotoğrafı yükleyebilirsiniz. Yüklemek için dokunun", size: "m",maxLines: 3,),
              Obx(() => Visibility(
                visible: controller.selectedImage.value != null,
                child: InkWell(
                  onTap: () {
                    controller.clearImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RegularText(
                      texts: "Yükleneni kaldır",
                      color: colors.red,
                      size: "s",
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
        Obx(() {
          return InkWell(
            onTap: () {
              pickImage();
            },
            child: Container(
              width: 58,
              height: 84,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: controller.selectedImage.value != null
                    ? DecorationImage(
                  image: FileImage(controller.selectedImage.value!),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: controller.selectedImage.value == null
                  ? Icon(Icons.camera_alt_rounded, color: colors.blue)
                  : null,
            ),
          );
        }),
      ],
    ),
  );
}

