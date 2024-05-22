import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/settings/settings.dart';

class UserInfoWidget extends StatefulWidget {

  final OkuurUserInfo userData;

  const UserInfoWidget({
    Key? key,
    required this.userData
  }) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Row(
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
                highlightColor: colors.greenDark,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: iconContainer(36,36, colors.greenDark, "assets/icons/settings.png"),
              ),
              iconContainer(36,46, colors.blue, "assets/icons/star_filled.png")

            ],
          ),
        )


      ],
    );
  }

  Container profilePhoto(String url){
    return Container(
      width: 86,
      height: 86,
      decoration: BoxDecoration(
        color: colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(28))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(url),
      ),
    );
  }

  SizedBox proileTexts(){
    OkuurUserInfo userData = widget.userData;
    DateTime dateTime = DateTime.parse(userData.creationTime);
    return SizedBox(
      height: 86,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text("${userData.name} ${userData.surname}", colors.black, 12, "FontMedium",1),
          text("@${userData.username}", colors.greenDark, 14, "FontBold",1),
          Spacer(),
          text("Katıldı: ${dateTime.day} ${months[dateTime.month]} ${dateTime.year}", colors.black, 12, "FontMedium",1),
          Spacer(),
          text("Yıldızlayanlar: 16", colors.black, 12, "FontMedium",1)
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
        child: Image.asset(path),
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