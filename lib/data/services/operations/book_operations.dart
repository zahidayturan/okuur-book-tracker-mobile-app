import 'dart:async';
import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/book_service.dart';


class BookOperations implements BookService {

  @override
  Future<void> insertBookInfo(OkuurBookInfo bookInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    FirebaseFirestoreOperation().addBookInfoToFirestore(uid!, bookInfo);
  }


  @override
  Future<List<OkuurBookInfo>?> getBookInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirebaseFirestoreOperation().getBookInfo(uid!);
    return result;
  }

  @override
  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirebaseFirestoreOperation().getCurrentlyReadBooksInfo(uid!);
    return result;
  }


  @override
  Future<void> deleteAllBookInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirebaseFirestoreOperation().deleteAllBookInfo(uid!);
  }
}
