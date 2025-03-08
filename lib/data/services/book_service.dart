import 'dart:async';
import 'dart:io';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';

abstract class BookService {

  Future<void> insertBookInfo(OkuurBookInfo bookInfo,File? image);

  Future<List<OkuurBookInfo>?> getBookInfo();

  Future<void> updateBookInfo(OkuurBookInfo okuurBookInfo);

  Future<OkuurBookInfo?> getBookInfoWithId(String bookId);

  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo();

  Future<void> deleteBookAndLogInfo(String bookId);

  Future<void> deleteAllBookInfo();

  Future<void> updateBookInfoAfterLog(OkuurLogInfo logInfo,int type, OkuurLogInfo? updatedLog);

  Future<Map<String,dynamic>> getTotalBookAndPage();
}
