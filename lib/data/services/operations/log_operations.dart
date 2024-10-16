import 'dart:async';
import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/log_service.dart';


class LogOperations implements LogService {

  @override
  Future<void> insertLogInfo(OkuurLogInfo logInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirebaseFirestoreOperation().addLogInfoToFirestore(uid!, logInfo);
  }

  @override
  Future<List<OkuurLogInfo>?> getLogInfo(String bookId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirebaseFirestoreOperation().getLogInfo(uid!,bookId);
    return result;
  }
}
