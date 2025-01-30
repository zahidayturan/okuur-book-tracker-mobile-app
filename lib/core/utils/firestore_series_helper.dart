import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okuur/data/models/okuur_series_info.dart';

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
}