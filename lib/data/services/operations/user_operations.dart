import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/data/services/user_service.dart';

class UserOperations implements UserService {

  @override
  Future<void> insertUserInfo(OkuurUserInfo okuurUserInfo) async {
    await FirebaseFirestoreOperation().addOkuurUserInfoToFirestore(okuurUserInfo);
  }

  @override
  Future<OkuurUserInfo?> getActiveUserInfoByUId() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var user = await FirebaseFirestoreOperation().getUserInfo(uid!);
    return user;
  }

  @override
  Future<OkuurUserProfileInfo?> getActiveUserProfileInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    var profileInfo = await FirebaseFirestoreOperation().getUserProfileInfo(uid!);
    return profileInfo;
  }

}