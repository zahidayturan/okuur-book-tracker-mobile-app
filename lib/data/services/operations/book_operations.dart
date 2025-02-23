import 'dart:async';
import 'dart:io';
import 'package:okuur/core/utils/firestore_book_helper.dart';
// import 'package:okuur/core/utils/firebase_storage_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/book_service.dart';


class BookOperations implements BookService {

  @override
  Future<void> insertBookInfo(OkuurBookInfo bookInfo,File? image) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    //String imageId = await FirebaseStorageOperation().uploadBookCoverImage(image);
    //bookInfo.imageLink = imageId;
    await FirestoreBookOperation().addBookInfoToFirestore(uid!, bookInfo);
  }


  @override
  Future<List<OkuurBookInfo>?> getBookInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreBookOperation().getBookInfo(uid!);
    return result;
  }

  @override
  Future<void> updateBookInfo(OkuurBookInfo okuurBookInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreBookOperation().updateBookInfo(uid!,okuurBookInfo);
  }

  @override
  Future<OkuurBookInfo?> getBookInfoWithId(String bookId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreBookOperation().getSingleBookInfo(uid!,bookId);
    return result;
  }

  @override
  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreBookOperation().getCurrentlyReadBooksInfo(uid!);
    return result;
  }

  @override
  Future<void> deleteBookAndLogInfo(String bookId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreBookOperation().deleteBookAndLogInfo(uid!,bookId);
  }

  @override
  Future<void> deleteAllBookInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreBookOperation().deleteAllBookInfo(uid!);
  }

  @override
  Future<OkuurBookInfo> updateBookInfoAfterLog(OkuurLogInfo logInfo,bool isAdd) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    OkuurBookInfo? book = await getBookInfoWithId(logInfo.bookId);
    if (book == null) {
      throw Exception('Book not found!');
    }
    if(isAdd){//insert log
      var newCurrentPage = book.currentPage + logInfo.numberOfPages;
      if (newCurrentPage >= book.pageCount) {
        //book finished
        book.currentPage = book.pageCount;
        book.status += 1;
        book.finishingDate = DateTime.now().toString();
      } else {
        book.currentPage = newCurrentPage;
      }
      book.totalReading += logInfo.numberOfPages;
      book.readingTime += logInfo.timeRead;
    }else{//delete log
      var newCurrentPage = book.currentPage - logInfo.numberOfPages;
      if (newCurrentPage <= 0) {
        //book not started
        book.currentPage = 0;
        book.finishingDate = "finishingDate";
      } else {
        book.currentPage = newCurrentPage;
      }
      book.totalReading -= logInfo.numberOfPages;
      book.readingTime -= logInfo.timeRead;
    }
    await FirestoreBookOperation().updateBookInfo(uid!, book);
    return book;
  }

  @override
  Future<Map<String,dynamic>> getTotalBookAndPage() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    return await FirestoreBookOperation().getTotalBookAndPageInfo(uid!);
  }
}
