import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/settings/settings.dart';
import 'package:okuur/ui/components/regular_text.dart';

class UserInfoWidget extends StatefulWidget {

  final OkuurUserInfo userData;
  final OkuurUserProfileInfo userInfo;

  const UserInfoWidget({
    Key? key,
    required this.userData,
    required this.userInfo
  }) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                profilePhoto("assets/icons/reads.png"),
                const SizedBox(width: 12,),
                proileTexts()
              ],
            ),
            SizedBox(
              height: 86,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, animation, nextanim) => const SettingsPage(),
                          reverseTransitionDuration: const Duration(milliseconds: 1),
                          transitionsBuilder: (context, animation, nexttanim, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    highlightColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: iconContainer(36,36, Theme.of(context).colorScheme.onPrimaryContainer, "assets/icons/settings.png"),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        userStarInfo()
      ],
    );
  }

  Container profilePhoto(String url){
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        shape: BoxShape.circle
      ),
      child: Icon(Icons.photo_camera_rounded,color: colors.greyMid,),
    );
  }

  SizedBox proileTexts(){
    OkuurUserInfo userData = widget.userData;
    DateTime dateTime = DateTime.parse(userData.creationTime);
    return SizedBox(
      height: 86,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [RegularText(texts:"${userData.name} ${userData.surname}", maxLines: 2),
              RegularText(texts: "@${userData.username}",  otherSize:14.0, family: "FontBold")],
          ),
          RegularText(texts:"Katıldın: ${dateTime.day} ${months[dateTime.month]} ${dateTime.year}"),
        ],
      ),
    );
  }

  Container iconContainer(double width,double height,Color color,String path){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(50))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path,color: Theme.of(context).colorScheme.secondary,),
      ),
    );
  }

  Widget userStarInfo(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        userStarBox(Theme.of(context).colorScheme.surface,colors.green,"Yıldızladıkların",widget.userInfo.followed),
        const SizedBox(width: 12,),
        userStarBox(Theme.of(context).colorScheme.primaryContainer,colors.greenDark,"Yıldızlayanlar",widget.userInfo.follower)
      ],
    );
  }

  Expanded userStarBox(Color textColor,Color boxColor,String text,int stars){
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 250,minHeight: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).colorScheme.onPrimaryContainer
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: RegularText(texts: text,color: textColor,size: "m",align: TextAlign.center)),
            Container(
              constraints: const BoxConstraints(minWidth: 30,minHeight: 20),
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: RegularText(texts:stars.toString(),color: colors.grey,size: "m"),
                )))
          ],
        ),
      ),
    );
  }

  List<String> months = [
    "",
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

}