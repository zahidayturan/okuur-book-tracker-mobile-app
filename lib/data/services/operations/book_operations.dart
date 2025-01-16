import 'dart:async';
import 'package:intl/intl.dart';
import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/book_service.dart';


class BookOperations implements BookService {

  @override
  Future<void> insertBookInfo(OkuurBookInfo bookInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirebaseFirestoreOperation().addBookInfoToFirestore(uid!, bookInfo);
  }


  @override
  Future<List<OkuurBookInfo>?> getBookInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirebaseFirestoreOperation().getBookInfo(uid!);
    return result;
  }

  @override
  Future<OkuurBookInfo?> getBookInfoWithId(String bookId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirebaseFirestoreOperation().getSingleBookInfo(uid!,bookId);
    return result;
  }

  @override
  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirebaseFirestoreOperation().getCurrentlyReadBooksInfo(uid!);
    return result;
  }

  @override
  Future<void> deleteBookAndLogInfo(String bookId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirebaseFirestoreOperation().deleteBookAndLogInfo(uid!,bookId);
  }

  @override
  Future<void> deleteAllBookInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirebaseFirestoreOperation().deleteAllBookInfo(uid!);
  }

  @override
  Future<void> updateBookInfoAfterLog(OkuurLogInfo logInfo,bool isAdd) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    OkuurBookInfo? book = await getBookInfoWithId(logInfo.bookId);
    if (book == null) {
      throw Exception('Book not found!');
    }
    if(isAdd){
      var newCurrentPage = book.currentPage + logInfo.numberOfPages;
      if (newCurrentPage >= book.pageCount) {
        //book finished
        book.currentPage = book.pageCount;
        book.status += 1;
        book.finishingDate = DateTime.now().toString();
      } else {
        book.currentPage = newCurrentPage;
      }
      book.readingTime += logInfo.timeRead;
    }else{
      var newCurrentPage = book.currentPage - logInfo.numberOfPages;
      if (newCurrentPage <= 0) {
        //book not started
        book.currentPage = 0;
        book.finishingDate = "finishingDate";
      } else {
        book.currentPage = newCurrentPage;
      }
      book.readingTime -= logInfo.timeRead;
    }

    await FirebaseFirestoreOperation().updateBookInfo(uid!, book);
  }

}
