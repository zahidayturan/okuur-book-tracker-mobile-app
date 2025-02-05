import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/controllers/okuur_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/localizations/l10n_extension.dart';
import 'package:okuur/ui/components/shimmer_box.dart';
import '../../../ui/components/rich_text.dart';

class HomeProfileInfo extends StatefulWidget {

  const HomeProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeProfileInfo> createState() => _HomeProfileInfoState();
}

class _HomeProfileInfoState extends State<HomeProfileInfo> {

  AppColors colors = AppColors();
  final OkuurController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  void initState() {
    homeController.fetchProfile(false);
    _selectRandomText();
    super.initState();
  }

  List<List<String>> plusTexts = [
    ['Kitap okuma maceran heyecan verici', '', ''],
    ['Yeni bir dünya keşfetmek harika', '', ''],
    ['Okumak seni yenilikte keşfe çıkarır', '',''],
    ['Kitaplar seni başka hayatlara götürür', '', ''],
    ['Yeni bir kitap yeni bir dünya', '', ''],
    ['Bol kitaplı günler', '', ''],
  ];

  List<String> selectedText = [];

  void _selectRandomText() {
    final random = Random();
    final randomIndex = random.nextInt(plusTexts.length);
    setState(() {
      selectedText = plusTexts[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.primaryContainer;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => homeController.homeProfileLoading.value
            ? const ShimmerBox(height: 32,width: 140,borderRadius: BorderRadius.all(Radius.circular(8)),)
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextWidget(
              texts: ['${context.translate.hello} ', (homeController.userInfo!.name)],
              colors: [mainColor],
              fontFamilies: const ['FontMedium', 'FontBold'],
            ),
            RichTextWidget(
              texts: homeController.totalMonthlyReads != null
              ? ['Bu ay ', '${homeController.totalMonthlyReads} sayfa',' kitap okudun']
              : selectedText,
              colors: [mainColor],
              fontSize: 13,
              fontFamilies: const ['FontMedium', 'FontBold','FontMedium'],
            ),
          ],
        )),
        InkWell(
          onTap: () {
            controller.setHomePageCurrentMode(5);
          },
          highlightColor: mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
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
    );
  }
}