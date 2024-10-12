import 'dart:async';
import 'package:okuur/data/models/okuur_log_info.dart';

abstract class LogService {

  Future<String> getLogTableName();

  Future<void> insertLogInfo(OkuurLogInfo logInfo);

  Future<List<OkuurLogInfo>> getLogInfo();
}
