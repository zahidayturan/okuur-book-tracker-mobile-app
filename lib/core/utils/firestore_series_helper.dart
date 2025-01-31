import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okuur/data/models/okuur_series_info.dart';
import 'package:okuur/ui/utils/date_formatter.dart';

class FirestoreSeriesOperation {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSeriesInfoToFirestore(String uid, OkuurSeriesInfo seriesInfo) async {
    try {
      if (seriesInfo.id == null || seriesInfo.id!.isEmpty) {
        seriesInfo.id = _firestore
            .collection('users')
            .doc(uid).collection('series')
            .doc().id;
      }
      Map<String, dynamic> seriesData = seriesInfo.toJson();

      await _firestore
          .collection('users')
          .doc(uid).collection('series')
          .doc(seriesInfo.id)
          .set(seriesData);

      debugPrint('Series added with ID: ${seriesInfo.id}');
    } catch (e) {
      debugPrint('Add Series Error: $e');
    }
  }

  Future<void> deleteSeriesInfo(String uid, String seriesId) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('series')
          .doc(seriesId)
          .delete();

      debugPrint('Series with ID $seriesId deleted successfully.');
    } catch (e) {
      debugPrint('Error deleting series with ID $seriesId: $e');
    }
  }

  Future<void> updateSeriesInfo(String uid, OkuurSeriesInfo seriesInfo) async {
    try {
      Map<String, dynamic> seriesData = seriesInfo.toJson();
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('series')
          .doc(seriesInfo.id)
          .update(seriesData);

      debugPrint('Series updated with ID: ${seriesInfo.id}');
    } catch (e) {
      debugPrint('Update Series Error: $e');
    }
  }

  Future<OkuurSeriesInfo?> getActiveSeriesInfo(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('series')
          .where('active', isEqualTo: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        if (querySnapshot.docs.length != 1) {
          DateTime? closestDate;
          OkuurSeriesInfo? closestSeries;

          for (var doc in querySnapshot.docs) {
            String date = OkuurSeriesInfo.fromJson(doc.data() as Map<String, dynamic>).startingDate;
            DateTime toDate = OkuurDateFormatter.stringToDateTime(date);

            if (closestDate == null || toDate.isBefore(closestDate)) {
              closestDate = toDate;
              closestSeries = OkuurSeriesInfo.fromJson(doc.data() as Map<String, dynamic>);
            }
          }

          if (closestSeries != null) {return closestSeries;}
        }
        else {
          return OkuurSeriesInfo.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Get Active Series Error: $e');
      return null;
    }
    return null;
  }

  Future<List<DateTime>> getAllSeriesInfo(String uid, DateTime startedDate, DateTime finishedDate) async {
    List<DateTime> seriesDates = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('series')
          .get();

        for (var doc in querySnapshot.docs) {
          String sDate = OkuurSeriesInfo.fromJson(doc.data() as Map<String, dynamic>).startingDate;
          DateTime docSDate = OkuurDateFormatter.stringToDateTime(sDate);

          String fDate = OkuurSeriesInfo.fromJson(doc.data() as Map<String, dynamic>).finishingDate;
          DateTime docFDate = OkuurDateFormatter.stringToDateTime(fDate);

          // Eğer belgenin tarih aralığı belirtilen aralıkla çakışıyorsa
          if ((docSDate.isBefore(finishedDate) && docFDate.isAfter(startedDate))) {
            DateTime currentDate = docSDate;

            while (currentDate.isBefore(docFDate) || currentDate.isAtSameMomentAs(docFDate)) {
              if (currentDate.isAfter(startedDate) && currentDate.isBefore(finishedDate) ||
                  currentDate.isAtSameMomentAs(startedDate) || currentDate.isAtSameMomentAs(finishedDate)) {
                seriesDates.add(currentDate); // Bu gün aralığa dahil, listeye ekle
              }
              currentDate = currentDate.add(const Duration(days: 1));
            }
          }
        }

    } catch (e) {
      debugPrint('Get Monthly Series Error: $e');
    }

    return seriesDates;
  }


}