import 'dart:async';
import 'package:okuur/core/utils/firestore_log_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/data/services/log_service.dart';

class LogOperations implements LogService {

  @override
  Future<void> insertLogInfo(OkuurLogInfo logInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreLogOperation().addLogInfoToFirestore(uid!, logInfo);
  }

  @override
  Future<List<OkuurLogInfo>> getLogInfo(String bookId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreLogOperation().getLogInfo(uid!,bookId);
    return result;
  }

  @override
  Future<List<OkuurLogInfo>> getAllLogForDate(DateTime dateTime) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var result = await FirestoreLogOperation().getLogInfoForDate(dateTime,uid!);
    return result;
  }

  @override
  Future<void> deleteLogInfo(OkuurLogInfo logInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreLogOperation().deleteLogInfo(uid!,logInfo);
  }

}