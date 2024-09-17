import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12,),
        SettingRow(color: Theme.of(context).colorScheme.primaryContainer, title: "Uygulama Dili", widget: OkuurDropdownMenu(
          list: ["Türkçe"],
          controller: _languageController,
          dropdownColor: colors.greenDark,
          textColor: colors.grey,
          padding: 8,
          fontSize: 13,
        )).getSettingRow(context),
      ],
    );
  }
}