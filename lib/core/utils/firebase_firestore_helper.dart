import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
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

  Future<void> updateBookInfo(String uid, OkuurBookInfo book) async {
    try {
      Map<String, dynamic> bookData = book.toJson();
      await _firestore.collection('users').doc(uid).collection('books').doc(book.id).update(bookData);
      print('Book updated with ID: ${book.id}');
    } catch (e) {
      print('Update Book Error: $e');
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
      print('Book with ID $bookId and its logs deleted successfully.');
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
      List<String> dateParts = log.readingDate.split('.');
      String monthYear = '${dateParts[1]}-${dateParts[2]}';

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
      print('Add Log Error: $e');
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
      print('Error fetching log data: $e');
      return [];
    }
  }

  Future<List<OkuurLogInfo>> getLogInfoForDate(String date, String uid) async {
    try {
      QuerySnapshot booksSnapshot = await _firestore.collection('users')
          .doc(uid)
          .collection('books')
          .get();

      List<String> dateParts = date.split('.');
      String monthYear = '${dateParts[1]}-${dateParts[2]}';
      List<OkuurLogInfo> logs = [];

      for (var bookDoc in booksSnapshot.docs) {
        QuerySnapshot logsSnapshot = await bookDoc.reference
            .collection('logs')
            .doc(monthYear)
            .collection('entries')
            .where('readingDate', isEqualTo: date)
            .get();

        if (logsSnapshot.docs.isNotEmpty) {
          logs.addAll(logsSnapshot.docs.map((doc) =>
              OkuurLogInfo.fromJson(doc.data() as Map<String, dynamic>)).toList());
        }
      }

      return logs.isNotEmpty ? logs : [];
    } catch (e) {
      print('Error fetching log data: $e');
      return [];
    }
  }

  Future<void> deleteLogInfo(String uid, OkuurLogInfo logInfo) async {
    List<String> dateParts = logInfo.readingDate.split('.');
    String monthYear = '${dateParts[1]}-${dateParts[2]}';
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

      print('Book log deleted successfully.');
    } catch (e) {
      print('Error deleting book log: $e');
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