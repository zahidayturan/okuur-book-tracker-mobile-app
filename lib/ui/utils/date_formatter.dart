import 'package:intl/intl.dart';
import 'package:okuur/ui/const/month_name_list.dart';

class OkuurDateFormatter {

  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd.MM.yyyy').format(date);
  }

  static DateTime getDateNow(){
    return DateTime.now();
  }

  static String getDateNowFormat(){
    DateTime date = DateTime.now();
    return "${date.day} ${months[date.month]} ${date.year}";
  }

  static DateTime stringToDateTime(String date){
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  }

  static String convertDate(String startedDate){
    DateTime format = DateFormat("yyyy-MM-dd hh:mm:ss").parse(startedDate);
    return "${format.day}.${format.month}.${format.year}";
  }

  static String dateFormatToDb(String date){
    DateFormat inputFormat = DateFormat('dd.MM.yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  static String dateFormatFromDb(String date){
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(date);
    DateFormat outputFormat = DateFormat('dd.MM.yyyy');
    String formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

}