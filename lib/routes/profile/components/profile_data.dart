import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

class ProfileDataWidget extends StatefulWidget {


  const ProfileDataWidget({
    Key? key,
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
      physics: BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dataContainer("42","Kitap"),
          SizedBox(width: 12,),
          dataContainer("9760","Sayfa"),
          SizedBox(width: 12,),
          dataContainer("34 Gün","Aktif Seri"),
          SizedBox(width: 12,),
          dataContainer("86 Gün","En İyi Seri"),
          SizedBox(width: 12,),
          dataContainer("4750","Puan"),
          SizedBox(width: 12,),
          dataContainer("9","Başarım"),
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