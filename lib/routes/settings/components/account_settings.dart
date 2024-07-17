import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class AccountSettings extends StatefulWidget {

  const AccountSettings({
    super.key,
  });

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  AppColors colors = AppColors();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Column(
        children: [
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text("Hesap ayarlarını değiştir",style: TextStyle(fontSize: 13,color: colors.greenDark),),
            Image.asset("assets/icons/arrow.png",height: 16,color: colors.greenDark,)
          ],)
        ],
      ),
    );
  }
}