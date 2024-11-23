import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/dto/user_profile_info.dart';
import 'package:okuur/ui/components/rich_text.dart';

class ProfileDataWidget extends StatefulWidget {
  final OkuurUserProfileInfo userInfo;

  const ProfileDataWidget({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<ProfileDataWidget> createState() => _ProfileDataWidgetState();
}

class _ProfileDataWidgetState extends State<ProfileDataWidget> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dataContainer(widget.userInfo.totalBook.toString(),"Kitap"),
          SizedBox(width: 12,),
          dataContainer(widget.userInfo.totalPage.toString(),"Sayfa"),
          SizedBox(width: 12,),
          dataContainer(widget.userInfo.activeSeries.toString(),"Aktif Seri"),
          SizedBox(width: 12,),
          dataContainer(widget.userInfo.bestSeries.toString(),"En İyi Seri"),
          SizedBox(width: 12,),
          dataContainer(widget.userInfo.point.toString(),"Puan"),
          SizedBox(width: 12,),
          dataContainer(widget.userInfo.achievement.toString(),"Başarım"),
        ],
      ),
    );
  }

  Container dataContainer(String textBold,String textMedium){

    return Container(
      width: 98,
      height: 58,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: Center(
        child: RichTextWidget(
            texts: ["$textBold\n",textMedium],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: ["FontBold","FontMedium"],
            fontSize: 14,
            align: TextAlign.center),
      ),
    );
  }


}