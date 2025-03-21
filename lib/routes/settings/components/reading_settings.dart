import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
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
  final OkuurLocalStorage storage = OkuurLocalStorage();
  final TextEditingController _dailyGoalController = TextEditingController();
  List<String> numList = const ["10", "20", "30", "40", "50", "60", "80", "100", "120", "150", "200"];

  @override
  Widget build(BuildContext context) {
    int initialIndex = numList.indexWhere((element) => element == storage.getDailyGoal().toString());
    initialIndex = initialIndex == -1 ? 3 : initialIndex; // Eğer yok ise, default olarak 3(40)

    return Column(
      children: [
        const SizedBox(height: 12),
        SettingRow(
          color: Theme.of(context).colorScheme.primary,
          title: "Günlük Okuma Hedefi (sayfa)",
          widget: OkuurDropdownMenu(
            list: numList,
            controller: _dailyGoalController,
            dropdownColor: colors.blue,
            textColor: colors.white,
            onChanged: (value) {
              storage.saveDailyGoal(int.parse(value));
            },
            padding: 8,
            fontSize: 13,
            initialIndex: initialIndex,
          ),
        ).getSettingRow(context),
      ],
    );
  }
}
