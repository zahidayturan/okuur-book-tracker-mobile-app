import 'package:get/get.dart';

class StatisticsController extends GetxController {

  var selectedMonth = ''.obs;

  var months = <String>[
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    setInitialMonth();
  }

  void setInitialMonth() {
    DateTime now = DateTime.now();
    String currentMonth = months[now.month - 1];
    selectedMonth.value = currentMonth;
  }

  void setMonth(String month) {
    selectedMonth.value = month;
  }

  void resetToCurrentMonth() {
    setInitialMonth();
  }

  var selectedWeeklyInfoType = "Sayfa".obs;
}

