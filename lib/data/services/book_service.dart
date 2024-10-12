import 'dart:async';
import 'package:okuur/data/models/okuur_book_info.dart';

abstract class BookService {

  Future<String> getBookTableName();

  Future<void> insertBookInfo(OkuurBookInfo bookInfo);

  Future<List<OkuurBookInfo>> getBookInfo();

  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo();

  Future<void> deleteAllBookInfo();
}
