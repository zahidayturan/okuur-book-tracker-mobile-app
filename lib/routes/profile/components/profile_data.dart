import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/settings/settings.dart';
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
          dataContainer("42","Kitap",colors.orange,1),
          SizedBox(width: 12,),
          dataContainer("9760","Sayfa",colors.orange,0),
          SizedBox(width: 12,),
          dataContainer("34 Gün","Aktif Seri",colors.lemon,3),
          SizedBox(width: 12,),
          dataContainer("86 Gün","En İyi Seri",colors.lemon,2),
          SizedBox(width: 12,),
          dataContainer("4750","Puan",colors.red,0),
          SizedBox(width: 12,),
          dataContainer("9","Başarım",colors.yellow,3),
        ],
      ),
    );
  }

  Container dataContainer(String textBold,String textMedium,Color color,int radiusLocation){
    BorderRadiusGeometry getRadius(){
      Radius rad = Radius.circular(20);
      Radius locationRad = Radius.circular(5);
      if(radiusLocation == 0){
        return BorderRadius.only(topLeft: locationRad,topRight: rad,bottomLeft: rad,bottomRight: rad);
      }else if(radiusLocation == 1){
        return BorderRadius.only(topLeft: rad,topRight: locationRad,bottomLeft: rad,bottomRight: rad);
      }else if(radiusLocation == 2){
        return BorderRadius.only(topLeft: rad,topRight: rad,bottomLeft: locationRad,bottomRight: rad);
      }else{
        return BorderRadius.only(topLeft: rad,topRight: rad,bottomLeft: rad,bottomRight: locationRad);
      }
    }

    return Container(
      width: 98,
      height: 58,
      decoration: BoxDecoration(
          color: color,
          borderRadius: getRadius()
      ),
      child: Center(
        child: RichTextWidget(
            texts: ["$textBold\n",textMedium],
            colors: [colors.white,colors.white],
            fontFamilies: ["FontBold","FontMedium"],
            fontSize: 14,
            align: TextAlign.center),
      ),
    );
  }


}