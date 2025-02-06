import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/utils/firestore_book_helper.dart';
import 'package:okuur/core/utils/firestore_series_helper.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';

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

  Future<OkuurUserProfileInfo?> getUserProfileInfo(String uid) async {

    Map<String,dynamic>? totalInfo = await FirestoreBookOperation().getTotalBookAndPageInfo(uid);
    Map<String,dynamic>? seriesInfo = await FirestoreSeriesOperation().getBestAndActiveSeries(uid);

    OkuurUserProfileInfo userProfileInfo = OkuurUserProfileInfo(
        follower: 0,
        followed: 0,
        totalBook: totalInfo["book"],
        totalPage: totalInfo["totalReading"],
        activeSeries: seriesInfo["active"],
        bestSeries: seriesInfo["best"],
        point: int.parse((totalInfo["totalReading"]*1.2).toStringAsFixed(0)),
        achievement: 0);
    return userProfileInfo;
  }
}