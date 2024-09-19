import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/routes/settings/components/setting_row.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  AppColors colors = AppColors();
  final TextEditingController _themeController = TextEditingController();

  final OkuurController okuurController = Get.put(OkuurController());
  final OkuurLocalStorage storage = OkuurLocalStorage();

  final List<String> themeOptions = ["Aydınlık Tema", "Karanlık Tema","Sistem Teması"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        SettingRow(
          color: Theme.of(context).colorScheme.primaryContainer,
          title: "Uygulama Teması",
          widget: OkuurDropdownMenu(
            list: themeOptions,
            controller: _themeController,
            dropdownColor: colors.greenDark,
            textColor: colors.grey,
            padding: 8,
            fontSize: 13,
            initialIndex: storage.getTheme(),
            onChanged: (value) {
              int newThemeIndex = themeOptions.indexOf(value);
              okuurController.switchTheme(newThemeIndex,MediaQuery.of(context).platformBrightness == Brightness.dark);
            },
          ),
        ).getSettingRow(context),
      ],
    );
  }
}
