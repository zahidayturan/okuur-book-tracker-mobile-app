import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/profile/components/book_list_view.dart';
import 'package:okuur/routes/profile/components/profile_data.dart';
import 'package:okuur/routes/profile/components/user_info.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';
import 'package:okuur/ui/components/circular_progress.dart';
import 'package:okuur/ui/components/error_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final String? uid = _auth.currentUser?.uid;

    if (uid == null) {
      return Scaffold(
        body: Center(
          child: Text('No user is signed in.'),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavBar(pageIndex: 9,),
        body: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12,),
                FutureBuilder<OkuurUserInfo?>(
                  future: FirebaseFirestoreOperation().getUserInfo(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          height: 86,
                        child: GetProgressIndicator().getCircular(30, colors.blue),
                          );
                    } else if (snapshot.hasError) {
                      return SizedBox(
                          height: 86,
                          child: Center(child: ErrorText().error()));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return SizedBox(
                          height: 86,
                          child: Center(child: ErrorText().userDataNotFound()));
                    } else {
                      OkuurUserInfo userData = snapshot.data!;
                      return UserInfoWidget(userData: userData);
                    }
                  },
                ),
                const SizedBox(height: 18,),
                ProfileDataWidget(),
                const SizedBox(height: 18,),
                Expanded(child: BookListWidget())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
