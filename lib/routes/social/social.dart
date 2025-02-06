import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/page_header.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  PageHeaderTitle(
                      title: "Sosyal",
                      pathName: "assets/icons/navbar/social_d.png",
                      subtitle: ""
                  ).getTitle(context),
                  Column(
                    children: [
                      const SizedBox(height: 12,),
                      RichTextWidget(
                        texts: const ["Bu özellik ","Okuur+ ","aboneliği ile\nçok yakında aktif olacaktır"],
                        colors: [Theme.of(context).colorScheme.secondary,Theme.of(context).colorScheme.inversePrimary,Theme.of(context).colorScheme.secondary],
                        fontFamilies: const ["FontMedium","FontBold","FontMedium"],
                        align: TextAlign.center,
                      )
                    ],
                  ),
                  const SizedBox(height: 70)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}