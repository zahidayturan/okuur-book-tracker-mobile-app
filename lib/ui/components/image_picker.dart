import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OkuurImagePicker {
  final BuildContext context;

  OkuurImagePicker({required this.context});

  Future<File?> pickImageFromCamera() async {
    return await _pickImage(ImageSource.camera);
  }

  Future<File?> pickImageFromGallery() async {
    return await _pickImage(ImageSource.gallery);
  }

  Future<File?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
