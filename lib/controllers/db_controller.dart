import 'package:get/get.dart';
import 'package:okuur/core/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DbController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> checkOrCreateUserSpecificTables(String uid) async {
    final db = await databaseHelper.database;
    await _createLogInfoTable(db, uid);
    await _createBookInfoTable(db, uid);
  }

  Future<void> _createLogInfoTable(Database db, String uid) async {
    String logTableName = 'logInfo_$uid';
    print("new table name ${logTableName}");
    var logTableExists = await _checkIfTableExists(db, logTableName);
    print("tablo var mıymış ${logTableExists}");
    if (!logTableExists) {
      await db.execute('''
        CREATE TABLE $logTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          bookId INTEGER,
          numberOfPages INTEGER,
          timeRead INTEGER,
          readingDate TEXT,
          finishingTime TEXT
        )
      ''');
    }
  }

  Future<void> _createBookInfoTable(Database db, String uid) async {
    String bookTableName = 'bookInfo_$uid';
    var bookTableExists = await _checkIfTableExists(db, bookTableName);
    if (!bookTableExists) {
      await db.execute('''
        CREATE TABLE $bookTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          author TEXT,
          pageCount INTEGER,
          imageLink TEXT,
          type TEXT,
          startingDate TEXT,
          finishingDate TEXT,
          currentPage INTEGER,
          readingTime INTEGER,
          status INTEGER,
          logIds TEXT,
          rating REAL
        )
      ''');
    }
  }

  Future<bool> _checkIfTableExists(Database db, String tableName) async {
    var result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name=?", [tableName]);
    return result.isNotEmpty;
  }
}

