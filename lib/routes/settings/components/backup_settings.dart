import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/snackbar.dart';

class BackupSettings extends StatefulWidget {

  const BackupSettings({
    super.key,
  });

  @override
  State<BackupSettings> createState() => _BackupSettingsState();
}

class _BackupSettingsState extends State<BackupSettings> {
  AppColors colors = AppColors();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SnackBarWidget(context: context,duration: 3,backColor: colors.blackLight,textWidget: RegularText(texts: 'Okuur+\nAboneliği Gerektirir',maxLines: 2,color: colors.grey,align: TextAlign.center,)).showQuestionDialog();
      },
      child: Column(
        children: [
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Yedekleme tercihlerini değiştir",style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.primaryContainer),),
              Image.asset("assets/icons/arrow.png",height: 16,color: Theme.of(context).colorScheme.primaryContainer)
            ],)
        ],
      ),
    );
  }
}