import 'package:intl/intl.dart';

class OkuurDateFormatter {

  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static DateTime getDateNow(){
    return DateTime.now();
  }

  static String convertDate(String startedDate){
    DateTime format = DateFormat("yyyy-MM-dd hh:mm:ss").parse(startedDate);
    return "${format.day}.${format.month}.${format.year}";
  }

}