import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/data/services/user_service.dart';

class UserOperations implements UserService {

  @override
  Future<void> insertUserInfo(OkuurUserInfo okuurUserInfo) async {
    await FirebaseFirestoreOperation().addOkuurUserInfoToFirestore(okuurUserInfo);
  }

  @override
  Future<OkuurUserInfo?> getUserInfoByUId(String uid) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var user = await FirebaseFirestoreOperation().getUserInfo(uid!);
    return user;
  }
}