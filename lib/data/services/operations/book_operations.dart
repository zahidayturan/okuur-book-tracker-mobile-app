import 'dart:async';
import 'package:okuur/core/utils/database_helper.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/book_service.dart';
import 'package:sqflite/sqflite.dart';


class BookOperations implements BookService {
  @override
  Future<void> insertBookInfo(OkuurBookInfo bookInfo) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'bookInfo',
      bookInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Book added");
  }


  Future<List<OkuurBookInfo>> getBookInfo() async {
    final db = await DatabaseHelper().database;
    var result = await db.query('bookInfo', orderBy: "id");
    return result.map((book) => OkuurBookInfo.fromJson(book)).toList();
  }

  Future<void> deleteAllBookInfo() async {
    final db = await DatabaseHelper().database;
    await db.delete('bookInfo');
  }
}
