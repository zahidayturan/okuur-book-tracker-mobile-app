import 'package:okuur/data/models/okuur_user_info.dart';

abstract class UserService {

  Future<void> insertUserInfo(OkuurUserInfo okuurUserInfo);

  Future<OkuurUserInfo?> getUserInfoByUId(String uid);
}
