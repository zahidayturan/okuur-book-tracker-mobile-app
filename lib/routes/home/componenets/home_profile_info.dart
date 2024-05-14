import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
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
              ),
              RichTextWidget(
                texts: ['Bu ay ', '${widget.pageCount} sayfa',' kitap okudun'],
                colors: [colors.green, colors.green,colors.green],
                fontSize: 13,
                fontFamilies: ['FontMedium', 'FontBold','FontMedium'],
              ),
            ],
          ),
          Container(
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.greenDark,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/social.png"),
            ),
          )
        ],
      ),
    );
  }
}