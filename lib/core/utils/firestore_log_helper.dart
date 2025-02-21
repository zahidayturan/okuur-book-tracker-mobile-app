import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okuur/data/models/dto/home_log_info.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/ui/utils/date_formatter.dart';

class FirestoreLogOperation{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addLogInfoToFirestore(String uid, OkuurLogInfo log) async {
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

      return "ok";
    } catch (e) {
      debugPrint('Add Log Error: $e');
      return "err";
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

  Future<List<OkuurBookAndLogInfo>> getLogInfoForDate(DateTime dateTime, String uid) async {
    try {
      List<OkuurBookAndLogInfo> homeLogInfo = [];

      QuerySnapshot booksSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .get();

      DateTime startOfDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));

      String monthYear = '${dateTime.month}-${dateTime.year}';

      for (var bookDoc in booksSnapshot.docs) {
        QuerySnapshot logsSnapshot = await bookDoc.reference
            .collection('logs')
            .doc(monthYear)
            .collection('entries')
            .where('readingDate', isGreaterThanOrEqualTo: startOfDay.toString())
            .where('readingDate', isLessThan: endOfDay.toString())
            .get();

        OkuurBookInfo bookInfo = OkuurBookInfo.fromJson(bookDoc.data() as Map<String, dynamic>);

        if (logsSnapshot.docs.isNotEmpty) {
          List<OkuurLogInfo> logs = logsSnapshot.docs.map((doc) =>
              OkuurLogInfo.fromJson(doc.data() as Map<String, dynamic>)).toList();

          for (var log in logs) {
            homeLogInfo.add(OkuurBookAndLogInfo(bookInfo: bookInfo, okuurLogInfo: log));
          }
        }
      }

      return homeLogInfo.isNotEmpty ? homeLogInfo : [];
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

  Future<List<OkuurBookAndLogInfo>> getMonthlyLogInfo(String uid,DateTime dateTime) async {
    try {
      List<OkuurBookAndLogInfo> homeLogInfo = [];

      QuerySnapshot booksSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .get();

      String monthYear = '${dateTime.month}-${dateTime.year}';

      for (var bookDoc in booksSnapshot.docs) {
        QuerySnapshot logsSnapshot = await bookDoc.reference
            .collection('logs')
            .doc(monthYear)
            .collection('entries')
            .get();

        OkuurBookInfo bookInfo = OkuurBookInfo.fromJson(bookDoc.data() as Map<String, dynamic>);

        if (logsSnapshot.docs.isNotEmpty) {
          List<OkuurLogInfo> logs = logsSnapshot.docs.map((doc) =>
              OkuurLogInfo.fromJson(doc.data() as Map<String, dynamic>)).toList();

          for (var log in logs) {
            homeLogInfo.add(OkuurBookAndLogInfo(bookInfo: bookInfo, okuurLogInfo: log));
          }
        }
      }

      homeLogInfo.sort((a, b) {
        DateTime dateA = DateTime.parse(a.okuurLogInfo.readingDate);
        DateTime dateB = DateTime.parse(b.okuurLogInfo.readingDate);
        return dateB.compareTo(dateA);
      });

      return homeLogInfo.isNotEmpty ? homeLogInfo : [];
    } catch (e) {
      debugPrint('Error fetching log data: $e');
      return [];
    }
  }

  Future<List<OkuurLogInfo>> getLogsForDaily(String uid, DateTime startDate) async {
    try {
      List<OkuurLogInfo> logInfo = [];

      QuerySnapshot booksSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('books')
          .get();

      String startMonthYear = '${startDate.month}-${startDate.year}';

      DateTime startOfDay = DateTime(startDate.year, startDate.month, startDate.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));

      for (var bookDoc in booksSnapshot.docs) {
        QuerySnapshot logsSnapshot = await bookDoc.reference
            .collection('logs')
            .doc(startMonthYear)
            .collection('entries')
            .where('readingDate', isGreaterThanOrEqualTo: startOfDay.toString())
            .where('readingDate', isLessThan: endOfDay.toString())
            .get();

        if (logsSnapshot.docs.isNotEmpty) {
          List<OkuurLogInfo> logs = logsSnapshot.docs.map((doc) =>
              OkuurLogInfo.fromJson(doc.data() as Map<String, dynamic>)).toList();

          for (var log in logs) {
              logInfo.add(log);
          }
        }
      }

      return logInfo.isNotEmpty ? logInfo : [];
    } catch (e) {
      debugPrint('Error fetching log data: $e');
      return [];
    }
  }

}
