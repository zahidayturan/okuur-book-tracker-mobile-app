import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/settings/settings.dart';

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
                SizedBox(width: 12,),
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
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: iconContainer(36,36, Theme.of(context).colorScheme.onPrimaryContainer, "assets/icons/settings.png"),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 12),
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
            children: [text("${userData.name} ${userData.surname}", Theme.of(context).colorScheme.secondary, 12, "FontMedium",2),
              text("@${userData.username}", Theme.of(context).colorScheme.secondary, 14, "FontBold",1),],
          ),
          text("Katıldın: ${dateTime.day} ${months[dateTime.month]} ${dateTime.year}", Theme.of(context).colorScheme.secondary, 12, "FontMedium",1),
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
        borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path,color: Theme.of(context).colorScheme.secondary,),
      ),
    );
  }


  Text text(String text,Color color,double size, String family,int maxLines){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),overflow: TextOverflow.ellipsis,maxLines: maxLines,
    );
  }

  Widget userStarInfo(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        userStarBox(Theme.of(context).colorScheme.surface,colors.green,"Yıldızladıkların",widget.userInfo.followed),
        SizedBox(width: 12,),
        userStarBox(Theme.of(context).colorScheme.primaryContainer,colors.greenDark,"Yıldızlayanlar",widget.userInfo.follower)
      ],
    );
  }

  Expanded userStarBox(Color textColor,Color boxColor,String text,int stars){
    return Expanded(
      child: Container(
        constraints: BoxConstraints(maxWidth: 250,minHeight: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).colorScheme.onPrimaryContainer
        ),
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(text,style: TextStyle(color: textColor,fontSize: 13),textAlign: TextAlign.center,)),
            Container(
              constraints: BoxConstraints(minWidth: 30,minHeight: 20),
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(stars.toString(),style: TextStyle(color: colors.grey,fontSize: 13),),
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