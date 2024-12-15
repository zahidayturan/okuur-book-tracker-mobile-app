import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/profile_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/profile/components/profile_data.dart';
import 'package:okuur/routes/profile/components/user_info.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

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
                  ? loadingBox()
                  : Column(
                children: [
                  const SizedBox(height: 12),
                  UserInfoWidget(userData: controller.userInfo!,userInfo: controller.userProfileInfo!),
                  const SizedBox(height: 18),
                  ProfileDataWidget(userInfo: controller.userProfileInfo!),
                  // Expanded(child: BookListWidget())
                  const SizedBox(height: 64,)
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingBox() {
    return const Column(
      children: [
        SizedBox(height: 12),
        Row(
          children: [
            ShimmerBox(
              width: 82,
              height: 82,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  ShimmerBox(
                    height: 10,
                  ),
                  SizedBox(height: 12),
                  ShimmerBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ShimmerBox(height: 28),
        SizedBox(height: 12,),
        Row(
          children: [
            ShimmerBox(
              width: 98,
              height: 58,
            ),
            SizedBox(width: 12),
            ShimmerBox(
              width: 98,
              height: 58,
            ),
          ],
        ),
        SizedBox(height: 12),
        ShimmerBox(
          height: 112,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        SizedBox(height: 12),
        ShimmerBox(
          height: 112,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        SizedBox(height: 64,)
      ],
    );
  }
}
