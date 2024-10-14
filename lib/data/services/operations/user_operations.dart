import 'package:okuur/core/utils/database_helper.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/data/services/user_service.dart';
import 'package:sqflite/sqflite.dart';

class UserOperations implements UserService {

  @override
  Future<void> insertUserInfo(OkuurUserInfo okuurUserInfo) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      "users",
      okuurUserInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<OkuurUserInfo?> getUserInfoByUId(String uid) async {
    print(uid);
    final db = await DatabaseHelper().database;

    var result = await db.query(
      "users",
      where: "id = ?",
      whereArgs: [uid],
    );
    if (result.isNotEmpty) {
      return OkuurUserInfo.fromJson(result.first);
    } else {
      return null;
    }
  }
}