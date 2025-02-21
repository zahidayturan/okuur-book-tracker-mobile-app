import 'dart:async';
import 'package:okuur/core/utils/firestore_log_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/log_service.dart';
import 'package:okuur/data/services/operations/series_operations.dart';

class LogOperations implements LogService {

  @override
  Future<void> insertLogInfo(OkuurLogInfo logInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    String status= await FirestoreLogOperation().addLogInfoToFirestore(uid!, logInfo);
    if(status == "ok"){
      await SeriesOperations().newSeriesInfo(logInfo.readingDate);
    }
  }

  @override
  Future<List<OkuurLogInfo>> getLogInfo(String bookId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreLogOperation().getLogInfo(uid!,bookId);
    return result;
  }

  @override
  Future<List<OkuurBookAndLogInfo>> getAllLogForDate(DateTime dateTime) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreLogOperation().getLogInfoForDate(dateTime,uid!);
    return result;
  }

  @override
  Future<void> deleteLogInfo(OkuurLogInfo logInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreLogOperation().deleteLogInfo(uid!,logInfo);
  }

  @override
  Future<List<OkuurBookAndLogInfo>> getMonthlyLogInfo(DateTime dateTime) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreLogOperation().getMonthlyLogInfo(uid!,dateTime);
    return result;
  }

  @override
  Future<List<OkuurLogInfo>> getDailyLogInfo(DateTime dateTime) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreLogOperation().getLogsForDaily(uid!,dateTime);
    return result;
  }

}