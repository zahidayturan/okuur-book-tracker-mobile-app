import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/routes/settings/components/setting_row.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';

class LanguageSettings extends StatefulWidget {

  const LanguageSettings({
    super.key,
  });

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  AppColors colors = AppColors();
  final TextEditingController _languageController = TextEditingController();

  final OkuurController okuurController = Get.put(OkuurController());
  final OkuurLocalStorage storage = OkuurLocalStorage();

  final List<Map<String, String>> languageOptions = [
    {"name": "Türkçe", "code": "tr"},
    {"name": "English", "code": "en"}
  ];

  late int initialIndex;

  @override
  void initState() {
    super.initState();
    String storedLanguageCode = storage.getLanguage();
    initialIndex = languageOptions.indexWhere(
          (language) => language['code'] == storedLanguageCode,
    );

    if (initialIndex == -1) {
      initialIndex = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12,),
        SettingRow(color: Theme.of(context).colorScheme.primaryContainer, title: "Uygulama Dili", widget: OkuurDropdownMenu(
          list: languageOptions.map((language) => language['name']!).toList(),
          controller: _languageController,
          dropdownColor: colors.greenDark,
          textColor: colors.grey,
          padding: 8,
          fontSize: 13,
          initialIndex: initialIndex,
          onChanged: (value) {
            String newLanguageCode = languageOptions
                .firstWhere((language) => language['name'] == value)['code']!;
            okuurController.switchLocale(newLanguageCode);
          },
        )).getSettingRow(context),
      ],
    );
  }
}