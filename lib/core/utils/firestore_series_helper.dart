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

  Future<OkuurSeriesInfo> getActiveSeriesInfo(String uid) async {
    DateTime currentDate = DateTime.now();
    DateTime currentDayOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
    OkuurSeriesInfo tempInfo = OkuurSeriesInfo(active: false, dayCount: 0, startingDate: currentDate.toString(), finishingDate: currentDate.toString());

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
            OkuurSeriesInfo okuurSeriesInfo = OkuurSeriesInfo.fromJson(doc.data() as Map<String, dynamic>);
            DateTime toStartingDate = OkuurDateFormatter.stringToDateTime(okuurSeriesInfo.startingDate);
            DateTime toFinishingDate = OkuurDateFormatter.stringToDateTime(okuurSeriesInfo.finishingDate);

            if (closestDate == null || toStartingDate.isBefore(closestDate)) {
              closestDate = toStartingDate;

              Duration difference = currentDayOnly.difference(toFinishingDate);
              if (difference.inDays > 1) {
                // Bugün ile serinin bitiş tarihi arasındaki fark 1 günden fazla
                okuurSeriesInfo.active = false;
                await updateSeriesInfo(uid, okuurSeriesInfo);
                return tempInfo;
              }

              closestSeries = okuurSeriesInfo;
            }
          }

          if (closestSeries != null) {return closestSeries;}
        }
        else {
          OkuurSeriesInfo firstSeriesInfo = OkuurSeriesInfo.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
          DateTime toFinishingDate = OkuurDateFormatter.stringToDateTime(firstSeriesInfo.finishingDate);

          Duration difference = currentDayOnly.difference(toFinishingDate);
          if (difference.inDays > 1) {
            // Bugün ile serinin bitiş tarihi arasındaki fark 1 günden fazla
            firstSeriesInfo.active = false;
            await updateSeriesInfo(uid, firstSeriesInfo);
            return tempInfo;
          }
          return firstSeriesInfo;
        }
      } else {
        return tempInfo;
      }
    } catch (e) {
      debugPrint('Get Active Series Error: $e');
      return tempInfo;
    }
    return tempInfo;
  }

  Future<Map<String, dynamic>> getAllSeriesInfo(String uid, DateTime startedDate, DateTime finishedDate) async {
    List<DateTime> seriesDates = [];
    int bestSeries = 0;

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('series')
          .get();

      for (var doc in querySnapshot.docs) {
        OkuurSeriesInfo seriesInfo = OkuurSeriesInfo.fromJson(doc.data() as Map<String, dynamic>);

        String sDate = seriesInfo.startingDate;
        DateTime docSDate = OkuurDateFormatter.stringToDateTime(sDate);

        String fDate = seriesInfo.finishingDate;
        DateTime docFDate = OkuurDateFormatter.stringToDateTime(fDate);

        bestSeries = seriesInfo.dayCount > bestSeries ? seriesInfo.dayCount : bestSeries;

        // Eğer belgenin tarih aralığı belirtilen aralıkla çakışıyorsa
        if (docSDate.isBefore(finishedDate) && (docFDate.isAfter(startedDate) || docFDate.isAtSameMomentAs(startedDate))) {
          DateTime currentDate = docSDate;

          while (currentDate.isBefore(docFDate) || currentDate.isAtSameMomentAs(docFDate)) {
            if ((currentDate.isAfter(startedDate) && currentDate.isBefore(finishedDate)) ||
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

    return {
      'seriesDates': seriesDates,
      'bestSeries': bestSeries
    };
  }

  Future<Map<String, dynamic>> getBestAndActiveSeries(String uid) async {
    DateTime currentDate = DateTime.now();
    DateTime currentDayOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);

    Map<String, dynamic> result = {"active": 0, "best": 0};
    int bestSeries = 0;
    OkuurSeriesInfo? closestSeries;

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('series')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        if (querySnapshot.docs.length > 1) {
          for (var doc in querySnapshot.docs) {
            OkuurSeriesInfo docSeriesInfo = OkuurSeriesInfo.fromJson(doc.data() as Map<String, dynamic>);
            DateTime toStartingDate = OkuurDateFormatter.stringToDateTime(docSeriesInfo.startingDate);
            DateTime toFinishingDate = OkuurDateFormatter.stringToDateTime(docSeriesInfo.finishingDate);

            bestSeries = docSeriesInfo.dayCount > bestSeries ? docSeriesInfo.dayCount : bestSeries;

            if (docSeriesInfo.active == true && (closestSeries == null || toStartingDate.isBefore(OkuurDateFormatter.stringToDateTime(closestSeries.startingDate)))) {
              closestSeries = docSeriesInfo;
              Duration difference = currentDayOnly.difference(toFinishingDate);
              if (difference.inDays > 1) {
                docSeriesInfo.active = false;
                await updateSeriesInfo(uid, docSeriesInfo);
              }
            }
          }

          if (closestSeries != null) {
            result["active"] = closestSeries.dayCount;
          }
          result["best"] = bestSeries;
        } else {
          OkuurSeriesInfo firstSeriesInfo = OkuurSeriesInfo.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
          DateTime toFinishingDate = OkuurDateFormatter.stringToDateTime(firstSeriesInfo.finishingDate);

          Duration difference = currentDayOnly.difference(toFinishingDate);
          if (difference.inDays > 1 && firstSeriesInfo.active == true) {
            firstSeriesInfo.active = false;
            await updateSeriesInfo(uid, firstSeriesInfo);
          }

          result["active"] = firstSeriesInfo.dayCount;
          result["best"] = firstSeriesInfo.dayCount;
        }
      }

    } catch (e) {
      debugPrint('Get Active Series Error: $e');
      return result;
    }

    return result;
  }

}