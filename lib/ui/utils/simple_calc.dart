import 'package:intl/intl.dart';

class OkuurCalc {

  static String calcPercentage(int max, int min){
    if(max == 0 || min == 0){
      return "0";
    }else if(min>max) {
      return "100";
    }
    return (min/max).toStringAsFixed(1);
  }

  static int calcDaysBetween(String startDate, String endDate) {
    DateTime start = DateFormat("yyyy-MM-dd hh:mm:ss").parse(startDate);
    DateTime end = DateFormat("yyyy-MM-dd hh:mm:ss").parse(endDate);
    return end.difference(start).inDays;
  }
}