import 'dart:io';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'okuur_database3.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE logInfo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookId INTEGER,
        numberOfPages INTEGER,
        timeRead INTEGER,
        readingDate TEXT,
        finishingTime TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE bookInfo (
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
        logIds TEXT
      )
    ''');
  }

  Future<void> insertBookInfo(OkuurBookInfo bookInfo) async {
    final db = await database;
    await db.insert(
      'bookInfo',
      bookInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Kitap added");
  }

  Future<void> insertLogInfo(OkuurLogInfo logInfo) async {
    final db = await database;
    await db.insert(
      'logInfo',
      logInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OkuurBookInfo>> getBookInfo() async {
    final db = await database;
    var result = await db.query('bookInfo', orderBy: "id");
    return result.map((book) => OkuurBookInfo.fromJson(book)).toList();
  }

  Future<List<OkuurLogInfo>> getLogInfo() async {
    final db = await database;
    var result = await db.query('logInfo', orderBy: "id");
    return result.map((log) => OkuurLogInfo.fromJson(log)).toList();
  }



  Future<void> deleteAllBookInfo() async {
    final db = await database;
    await db.delete('bookInfo');
  }



}
