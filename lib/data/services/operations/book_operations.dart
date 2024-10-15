import 'dart:async';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/book_service.dart';


class BookOperations implements BookService {

  @override
  Future<String> getBookTableName() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    if (uid == null) {
      throw Exception("Aktif kullanıcı bulunamadı");
    }
    return 'bookInfo_$uid';
  }

  @override
  Future<void> insertBookInfo(OkuurBookInfo bookInfo) async {
    /*final db = await DatabaseHelper().database;
    String tableName = await getBookTableName();
    await db.insert(
      tableName,
      bookInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Book added");*/
  }


  @override
  Future<List<OkuurBookInfo>> getBookInfo() async {
    /*final db = await DatabaseHelper().database;
    String tableName = await getBookTableName();
    var result = await db.query(tableName, orderBy: "id");
    return result.map((book) => OkuurBookInfo.fromJson(book)).toList();*/
    return [];
  }

  @override
  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo() async {
    /*final db = await DatabaseHelper().database;
    String tableName = await getBookTableName();
    var result = await db.query(tableName, orderBy: "id", where: "status % 2 = 1");
    return result.map((book) => OkuurBookInfo.fromJson(book)).toList();*/
    return [];
  }


  @override
  Future<void> deleteAllBookInfo() async {
    /*final db = await DatabaseHelper().database;
    String tableName = await getBookTableName();
    await db.delete(tableName);*/
  }
}
