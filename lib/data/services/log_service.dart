import 'dart:async';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';

abstract class LogService {

  Future<void> insertLogInfo(OkuurLogInfo logInfo);

  Future<List<OkuurLogInfo>?> getLogInfo(String bookId);

  Future<List<OkuurHomeLogInfo>> getAllLogForDate(DateTime dateTime);

  Future<void> deleteLogInfo(OkuurLogInfo logInfo);

  Future<List<OkuurHomeLogInfo>> getMonthlyLogInfo(DateTime dateTime);

  Future<List<OkuurLogInfo>> getDailyLogInfo(DateTime dateTime);
}
