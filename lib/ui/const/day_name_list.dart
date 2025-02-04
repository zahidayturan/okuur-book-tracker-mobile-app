import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/core/localizations/l10n_extension.dart';

BuildContext context = Get.context!;

List<String> dayNames = [
  context.translate.monday,
  context.translate.sunday,
  context.translate.wednesday,
  context.translate.thursday,
  context.translate.friday,
  context.translate.saturday,
  context.translate.sunday
];