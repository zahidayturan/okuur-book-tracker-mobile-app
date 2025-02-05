import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/utils/date_formatter.dart';

class FirestoreBookOperation{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBookInfoToFirestore(String uid, OkuurBookInfo book) async {
    try {
      if (book.id == null || book.id!.isEmpty) {
        book.id = _firestore.collection('users').doc(uid).collection('books').doc().id;
      }
      Map<String, dynamic> bookData = book.toJson();

      await _firestore.collection('users').doc(uid).collection('books').doc(book.id).set(bookData);

      debugPrint('Book added with ID: ${book.id}');
    } catch (e) {
      debugPrint('Add Book Error: $e');
    }
  }

  Future<void> updateBookInfo(String uid, OkuurBookInfo book) async {
    try {
      Map<String, dynamic> bookData = book.toJson();
      await _firestore.collection('users').doc(uid).collection('books').doc(book.id).update(bookData);
      debugPrint('Book updated with ID: ${book.id}');
    } catch (e) {
      debugPrint('Update Book Error: $e');
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
      debugPrint('Error fetching book data: $e');
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
      debugPrint('Error fetching book data: $e');
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
      debugPrint('Error fetching currently read books: $e');
      return [];
    }
  }

  Future<void> deleteBookAndLogInfo(String uid, String bookId) async {
    try {
      var logsCollection = await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .doc(bookId)
          .collection('logs')
          .get();

      for (var logDoc in logsCollection.docs) {
        await logDoc.reference.delete();
      }

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .doc(bookId)
          .delete();
      debugPrint('Book with ID $bookId and its logs deleted successfully.');
    } catch (e) {
      debugPrint('Error deleting book with ID $bookId: $e');
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
      debugPrint('All books deleted successfully.');
    } catch (e) {
      debugPrint('Error deleting all books: $e');
    }
  }

  Future<Map<String, dynamic>> getTotalBookAndPageInfo(String uid) async {
    Map<String, dynamic> info = {};
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').doc(uid).collection("books").get();
      info["book"] = querySnapshot.size;

      int totalReading = 0;
      DateTime? firstReading;

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          OkuurBookInfo bookInfo = OkuurBookInfo.fromJson(doc.data() as Map<String, dynamic>);

          DateTime bookStartingDate = OkuurDateFormatter.stringToDateTime(bookInfo.startingDate);
          if (firstReading == null || bookStartingDate.isBefore(firstReading)) {
            firstReading = bookStartingDate;
          }

          totalReading += bookInfo.currentPage;
        }
      }

      if (firstReading != null) {
        int totalReadingDay = DateTime.now().difference(firstReading).inDays;
        info["totalReadingDay"] = totalReadingDay;
      } else {
        info["totalReadingDay"] = 0;
      }
      info["totalReading"] = totalReading;

      return info;
    } catch (e) {
      debugPrint('Error fetching book data: $e');
      return {};
    }
  }

}
