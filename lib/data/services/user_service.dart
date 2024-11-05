import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';

abstract class UserService {

  Future<void> insertUserInfo(OkuurUserInfo okuurUserInfo);

  Future<OkuurUserInfo?> getActiveUserInfoByUId();

  Future<OkuurUserProfileInfo?> getActiveUserProfileInfo();
}
