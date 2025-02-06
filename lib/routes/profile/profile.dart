import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/profile_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/profile/components/book_list_view.dart';
import 'package:okuur/routes/profile/components/profile_data.dart';
import 'package:okuur/routes/profile/components/profile_loading.dart';
import 'package:okuur/routes/profile/components/user_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppColors colors = AppColors();
  ProfileController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Obx(() => controller.profileLoading.value
                  ? profileLoadingBox(context)
                  : Column(
                children: [
                  const SizedBox(height: 12),
                  UserInfoWidget(userData: controller.userInfo!,userInfo: controller.userProfileInfo!),
                  const SizedBox(height: 18),
                  ProfileDataWidget(userInfo: controller.userProfileInfo!),
                  const SizedBox(height: 18),
                  const BookListWidget(),
                  const SizedBox(height: 70)
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
