import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/profile/profile.dart';
import '../../../ui/components/rich_text.dart';

class HomeProfileInfo extends StatefulWidget {

  final String userName;
  final int pageCount;


  const HomeProfileInfo({
    Key? key,
    required this.userName,
    required this.pageCount,
  }) : super(key: key);

  @override
  State<HomeProfileInfo> createState() => _HomeProfileInfoState();
}

class _HomeProfileInfoState extends State<HomeProfileInfo> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTextWidget(
                texts: ['Merhaba ', '${widget.userName}'],
                colors: [colors.greenDark, colors.greenDark],
                fontSize: 15,
                fontFamilies: ['FontMedium', 'FontBold'],
                align: TextAlign.start,
              ),
              RichTextWidget(
                texts: ['Bu ay ', '${widget.pageCount} sayfa',' kitap okudun'],
                colors: [colors.green, colors.green,colors.green],
                fontSize: 13,
                fontFamilies: ['FontMedium', 'FontBold','FontMedium'],
                align: TextAlign.start,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 100),
                  pageBuilder: (context, animation, nextanim) => const ProfilePage(),
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
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Container(
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.greenDark,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/icons/social.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}