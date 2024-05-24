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
    String path = join(documentsDirectory.path, 'okuur_database2.db');
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
        status TEXT,
        logIds TEXT
      )
    ''');
  }
}
