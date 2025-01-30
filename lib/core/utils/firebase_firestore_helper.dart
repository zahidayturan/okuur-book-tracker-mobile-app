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