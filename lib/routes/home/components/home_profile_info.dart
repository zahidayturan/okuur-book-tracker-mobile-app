import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/okuur_controller.dart';
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
  final OkuurController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.primaryContainer;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTextWidget(
                texts: ['Merhaba ', '${widget.userName}'],
                colors: [mainColor],
                fontFamilies: ['FontMedium', 'FontBold'],
              ),
              RichTextWidget(
                texts: ['Bu ay ', '${widget.pageCount} sayfa',' kitap okudun'],
                colors: [mainColor],
                fontSize: 13,
                fontFamilies: ['FontMedium', 'FontBold','FontMedium'],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              controller.setHomePageCurrentMode(5);
            },
            highlightColor: mainColor,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Container(
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/icons/social.png",color: Theme.of(context).primaryColor,),
              ),
            ),
          )
        ],
      ),
    );
  }
}