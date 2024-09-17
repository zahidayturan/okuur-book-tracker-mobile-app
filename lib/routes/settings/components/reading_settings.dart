import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/settings/components/setting_row.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';

class ReadingSettings extends StatefulWidget {

  const ReadingSettings({
    super.key,
  });

  @override
  State<ReadingSettings> createState() => _ReadingSettingsState();
}

class _ReadingSettingsState extends State<ReadingSettings> {
  AppColors colors = AppColors();
  final TextEditingController _themeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12,),
        SettingRow(color: Theme.of(context).colorScheme.primary, title: "Günlük Okuma Hedefi", widget: OkuurDropdownMenu(
          list: ["50"],
          controller: _themeController,
          dropdownColor: colors.blue,
          textColor: colors.white,
          padding: 8,
          fontSize: 13,
          initialIndex: 0,
        )).getSettingRow(context),
      ],
    );
  }
}