import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/settings/components/setting_row.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';

class ThemeSettings extends StatefulWidget {

  const ThemeSettings({
    super.key,
  });

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  AppColors colors = AppColors();
  final TextEditingController _themeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          SizedBox(height: 12,),
          SettingRow(color: Theme.of(context).colorScheme.primaryContainer, title: "Uygulama Teması", widget: OkuurDropdownMenu(
            list: ["Aydınlık Tema","Karanlık Tema"],
            controller: _themeController,
            dropdownColor: colors.greenDark,
            textColor: colors.grey,
            padding: 8,
            fontSize: 13,
          )).getSettingRow(context),
      ],
    );
  }
}