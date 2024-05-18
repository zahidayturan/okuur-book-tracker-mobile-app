import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

class UserInfo extends StatefulWidget {

  //get UserInfo

  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

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
              iconContainer(36,36, colors.greenDark, "assets/icons/settings.png"),
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
    return SizedBox(
      height: 86,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text("user.name user.surname", colors.black, 12, "FontMedium",1),
          text("@user.username", colors.greenDark, 14, "FontBold",1),
          Spacer(),
          text("Katıldı: 16 Nisan 2024", colors.black, 12, "FontMedium",1),
          Spacer(),
          text("Katıldı: 16 Nisan 2024", colors.black, 12, "FontMedium",1)
        ],
      ),
    );
  }

  InkWell iconContainer(double width,double height,Color color,String path){
    return InkWell(
      onTap: () {

      },
      child: Container(
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

}