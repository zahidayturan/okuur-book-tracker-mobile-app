import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/localizations/l10n_extension.dart';
import 'package:okuur/routes/settings/account_settings.dart';

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
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, animation, nextanim) => const AccountSettingsPage(),
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
      child: Column(
        children: [
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text(context.translate.account_sub,style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.primaryContainer),),
            Image.asset("assets/icons/arrow.png",height: 16,color: Theme.of(context).colorScheme.primaryContainer)
          ],)
        ],
      ),
    );
  }
}