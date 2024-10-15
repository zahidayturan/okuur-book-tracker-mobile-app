import 'dart:async';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/log_service.dart';


class LogOperations implements LogService {

  @override
  Future<String> getLogTableName() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    if (uid == null) {
      throw Exception("Aktif kullanıcı bulunamadı");
    }
    return 'logInfo_$uid';
  }

  @override
  Future<void> insertLogInfo(OkuurLogInfo logInfo) async {
    /*final db = await DatabaseHelper().database;
    String tableName = await getLogTableName();
    await db.insert(
      tableName,
      logInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );*/
  }

  @override
  Future<List<OkuurLogInfo>> getLogInfo() async {
    /*final db = await DatabaseHelper().database;
    String tableName = await getLogTableName();
    var result = await db.query(tableName, orderBy: "id");
    return result.map((log) => OkuurLogInfo.fromJson(log)).toList();*/
    return [];
  }
}
