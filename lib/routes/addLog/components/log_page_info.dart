import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import '../../../ui/components/rich_text.dart';

class LogPageInfo extends StatefulWidget {
  const LogPageInfo({Key? key,}) : super(key: key);

  @override
  State<LogPageInfo> createState() => _LogPageInfoState();
}

class _LogPageInfoState extends State<LogPageInfo> {
  AppColors colors = AppColors();

  final AddLogController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Obx(() => Visibility(
      visible: controller.logBookId.value != null,
      child: Column(
        children: [
          const SizedBox(height: 12,),
          formContent(),
        ],
      ),
    ));
  }

  double _currentPageCount = 141;

  void _updatePageCount(double value) {
    setState(() {
      _currentPageCount = value;
    });
  }

  Widget formContent() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            texts: const ["Kaç Sayfa ","Okudunuz"],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: const ["FontBold","FontMedium"],
          ),
          const Row(
            children: [
              SizedBox(height: 8,),
            ],
          ),
          italicText("Kralın Dönüşü kitabı 360 sayfa. Siz 140. sayfada kalmıştınız."),
          const SizedBox(height: 12,),
          Row(
            children: [
              RichTextWidget(
                  texts: ["Eski\nSayfanız\n","140"],
                  colors: [Theme.of(context).colorScheme.secondary],
                  fontFamilies: ["FontMedium","FontBold"],
                  align: TextAlign.center,
                fontSize: 14,
              ),
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: Slider(
                    value: _currentPageCount,
                    min: 141,
                    max: 360,
                    divisions: (360 - 141).toInt(),
                    label: _currentPageCount.toInt().toString(),
                    onChanged: _updatePageCount,
                    activeColor: colors.blue,
                    inactiveColor: Theme.of(context).colorScheme.inverseSurface,
                    onChangeEnd: (value) {
                      controller.setLogNewCurrentPage(_currentPageCount.toInt());
                    },
                  ),
                ),
              ),
              RichTextWidget(
                texts: ["Yeni\nSayfanız\n","${_currentPageCount.toInt().toString()}"],
                colors: [Theme.of(context).colorScheme.inversePrimary],
                fontFamilies: ["FontMedium","FontBold"],
                align: TextAlign.center,
                fontSize: 14,
              )
            ],
          )
        ],
      ),
    );
  }


  Widget italicText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.secondary
      ),
    );
  }
}