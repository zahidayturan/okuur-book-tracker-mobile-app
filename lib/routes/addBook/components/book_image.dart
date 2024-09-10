import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/image_picker.dart';
import 'package:okuur/ui/components/rich_text.dart';

AppColors colors = AppColors();

Container addBookImage() {
  final AddBookController controller = Get.find(); // Find the controller

  Future<void> _pickImage() async {
    try {
      final pickerService = OkuurImagePicker(context: Get.context!);
      final File? selectedImage = await pickerService.pickImageFromCamera();

      if (selectedImage != null) {
        controller.setImage(selectedImage); // Update the image in the controller
      }
    } catch (e) {
      print("Image picking failed: $e");
    }
  }

  return Container(
    decoration: BoxDecoration(
      color: colors.white,
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
                  texts: ["Kitabın ","Kapak Fotoğrafı"],
                  colors: [colors.black,colors.black],
                  fontFamilies: ["FontMedium","FontBold"],
                  fontSize: 15,
                  align: TextAlign.start),
              const SizedBox(height: 4),
              const Text(
                "İsterseniz kapak fotoğrafı yükleyebilirsiniz. Yüklemek için dokunun",
                style: TextStyle(fontSize: 13),
              ),
              Obx(() => Visibility(
                visible: controller.selectedImage.value != null,
                child: InkWell(
                  onTap: () {
                    controller.clearImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Yükleneni kaldır",
                      style: TextStyle(color: colors.red),
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
              _pickImage();
            },
            child: Container(
              width: 58,
              height: 84,
              decoration: BoxDecoration(
                color: colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: controller.selectedImage.value != null
                    ? DecorationImage(
                  image: FileImage(controller.selectedImage.value!),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: controller.selectedImage.value == null
                  ? Icon(Icons.camera_alt_rounded, color: colors.greenDark)
                  : null,
            ),
          );
        }),
      ],
    ),
  );
}

