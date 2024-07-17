import 'dart:async';
import 'package:okuur/core/utils/database_helper.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/log_service.dart';
import 'package:sqflite/sqflite.dart';


class LogOperations implements LogService {

  Future<void> insertLogInfo(OkuurLogInfo logInfo) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'logInfo',
      logInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OkuurLogInfo>> getLogInfo() async {
    final db = await DatabaseHelper().database;
    var result = await db.query('logInfo', orderBy: "id");
    return result.map((log) => OkuurLogInfo.fromJson(log)).toList();
  }
}
