import 'package:get/get.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/data/services/operations/user_operations.dart';

class ProfileController extends GetxController {
  OkuurUserInfo? userInfo;
  OkuurUserProfileInfo? userProfileInfo;

  var profileLoading = Rx<bool>(false);

  Future<void> fetchProfile() async {
    profileLoading.value = true;
    userInfo = await UserOperations().getActiveUserInfoByUId();
    userProfileInfo = await UserOperations().getActiveUserProfileInfo();
    profileLoading.value = false;
  }
}