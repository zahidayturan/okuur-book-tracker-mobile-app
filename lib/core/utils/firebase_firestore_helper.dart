import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/ui/utils/date_formatter.dart';


class FirebaseFirestoreOperation{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addOkuurUserInfoToFirestore(OkuurUserInfo user) async {
    try {
      Map<String, dynamic> userData = user.toJson();
      await _firestore.collection('users').doc(user.id).set(userData);
    } catch (e) {
      debugPrint('Add User Error: $e');
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
      debugPrint('Error fetching user data: $e');
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

  Future<void> addLogInfoToFirestore(String uid, OkuurLogInfo log) async {
    try {
      DateTime logDate = OkuurDateFormatter.stringToDateTime(log.readingDate);
      String monthYear = '${logDate.month}-${logDate.year}';

      DocumentReference logDocRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .doc(log.bookId)
          .collection('logs')
          .doc(monthYear);

      DocumentSnapshot docSnapshot = await logDocRef.get();
      if (!docSnapshot.exists) {
        await logDocRef.set({
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      if (log.id == null || log.id!.isEmpty) {
        log.id = logDocRef.collection('entries').doc().id;
      }

      Map<String, dynamic> logData = log.toJson();

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .doc(log.bookId)
          .collection('logs')
          .doc(monthYear)
          .collection('entries')
          .doc(log.id)
          .set(logData);

    } catch (e) {
      debugPrint('Add Log Error: $e');
    }
  }

  Future<List<OkuurLogInfo>> getLogInfo(String uid, String bookId) async {
    try {
      QuerySnapshot logsSnapshot = await _firestore.collection('users')
          .doc(uid)
          .collection('books')
          .doc(bookId)
          .collection("logs")
          .get();

      List<OkuurLogInfo> logs = [];

      for (var logDoc in logsSnapshot.docs) {
        QuerySnapshot entriesSnapshot = await logDoc.reference
            .collection("entries")
            .get();

        if (entriesSnapshot.docs.isNotEmpty) {
          logs.addAll(entriesSnapshot.docs.map((doc) {
            return OkuurLogInfo.fromJson(doc.data() as Map<String, dynamic>);
          }).toList());
        }
      }

      return logs.isNotEmpty ? logs : [];
    } catch (e) {
      debugPrint('Error fetching log data: $e');
      return [];
    }
  }

  Future<List<OkuurLogInfo>> getLogInfoForDate(DateTime dateTime, String uid) async {
    try {
      QuerySnapshot booksSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .get();

      DateTime startOfDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));

      String monthYear = '${dateTime.month}-${dateTime.year}';
      List<OkuurLogInfo> logs = [];

      for (var bookDoc in booksSnapshot.docs) {
        QuerySnapshot logsSnapshot = await bookDoc.reference
            .collection('logs')
            .doc(monthYear)
            .collection('entries')
            .where('readingDate', isGreaterThanOrEqualTo: startOfDay.toString())
            .where('readingDate', isLessThan: endOfDay.toString())
            .get();

        if (logsSnapshot.docs.isNotEmpty) {
          logs.addAll(logsSnapshot.docs.map((doc) =>
              OkuurLogInfo.fromJson(doc.data() as Map<String, dynamic>)).toList());
        }
      }

      return logs.isNotEmpty ? logs : [];
    } catch (e) {
      debugPrint('Error fetching log data: $e');
      return [];
    }
  }

  Future<void> deleteLogInfo(String uid, OkuurLogInfo logInfo) async {
    DateTime logDate = OkuurDateFormatter.stringToDateTime(logInfo.readingDate);
    String monthYear = '${logDate.month}-${logDate.year}';
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .doc(logInfo.bookId)
          .collection('logs')
          .doc(monthYear)
          .collection('entries')
          .doc(logInfo.id)
          .delete();

      debugPrint('Book log deleted successfully.');
    } catch (e) {
      debugPrint('Error deleting book log: $e');
    }
  }

  Future<OkuurUserProfileInfo?> getUserProfileInfo(String uid) async {
    OkuurUserProfileInfo userProfileInfo = OkuurUserProfileInfo(
        follower: 0,
        followed: 0,
        totalBook: 0,
        totalPage: 0,
        activeSeries: 0,
        bestSeries: 0,
        point: 0,
        achievement: 0);
    return userProfileInfo;
  }
}