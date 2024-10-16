import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';


class FirebaseFirestoreOperation{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addOkuurUserInfoToFirestore(OkuurUserInfo user) async {
    try {
      Map<String, dynamic> userData = user.toJson();
      await _firestore.collection('users').doc(user.id).set(userData);
    } catch (e) {
      print('Add User Error: $e');
    }
  }

  Future<OkuurUserInfo?> getUserInfo(String uid) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
        return userData != null ? OkuurUserInfo.fromJson(userData) : null;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  Future<void> addBookInfoToFirestore(String uid, OkuurBookInfo book) async {
    try {
      if (book.id == null || book.id!.isEmpty) {
        book.id = _firestore.collection('users').doc(uid).collection('books').doc().id;
      }
      Map<String, dynamic> bookData = book.toJson();

      await _firestore.collection('users').doc(uid).collection('books').doc(book.id).set(bookData);

      print('Book added with ID: ${book.id}');
    } catch (e) {
      print('Add Book Error: $e');
    }
  }


  Future<List<OkuurBookInfo>?> getBookInfo(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').doc(uid).collection("books").get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) => OkuurBookInfo.fromJson(doc.data() as Map<String, dynamic>)).toList();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching book data: $e');
      return null;
    }
  }

  Future<OkuurBookInfo?> getSingleBookInfo(String uid, String bookId) async {
    try {
      DocumentSnapshot bookSnapshot = await _firestore.collection('users').doc(uid).collection("books").doc(bookId).get();

      if (bookSnapshot.exists) {
        Map<String, dynamic>? bookData = bookSnapshot.data() as Map<String, dynamic>?;
        return bookData != null ? OkuurBookInfo.fromJson(bookData) : null;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching book data: $e');
      return null;
    }
  }

  Future<List<OkuurBookInfo>> getCurrentlyReadBooksInfo(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .where('status', isEqualTo: 1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => OkuurBookInfo.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching currently read books: $e');
      return [];
    }
  }

  Future<void> deleteBookInfo(String uid, String bookId) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .doc(bookId)
          .delete();
      print('Book with ID $bookId deleted successfully.');
    } catch (e) {
      print('Error deleting book with ID $bookId: $e');
    }
  }

  Future<void> deleteAllBookInfo(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      print('All books deleted successfully.');
    } catch (e) {
      print('Error deleting all books: $e');
    }
  }


  Future<void> addLogInfoToFirestore(String uid, OkuurLogInfo log) async {
    try {
      if (log.id == null || log.id!.isEmpty) {
        log.id = _firestore.collection('users').doc(uid).collection('books').doc(log.bookId).collection('logs').doc().id;
      }
      Map<String, dynamic> logData = log.toJson();

      await _firestore.collection('users').doc(uid).collection('books').doc(log.bookId).collection('logs').doc(log.id).set(logData);
    } catch (e) {
      print('Add Log Error: $e');
    }
  }

  Future<List<OkuurLogInfo>?> getLogInfo(String uid,String bookId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').doc(uid).collection('books').doc(bookId).collection("logs").get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) => OkuurLogInfo.fromJson(doc.data() as Map<String, dynamic>)).toList();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching log data: $e');
      return null;
    }
  }

}