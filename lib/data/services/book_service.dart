import 'dart:async';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';

abstract class BookService {

  Future<void> insertBookInfo(OkuurBookInfo bookInfo);

  Future<List<OkuurBookInfo>?> getBookInfo();

  Future<OkuurBookInfo?> getBookInfoWithId(String bookId);

  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo();

  Future<void> deleteBookInfo(String bookId);

  Future<void> deleteAllBookInfo();

  Future<void> updateBookInfoAfterLog(OkuurLogInfo logInfo);
}
