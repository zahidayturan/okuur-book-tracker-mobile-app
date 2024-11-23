import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
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

  void _updatePageCount(double value) {
    setState(() {
      controller.sliderBookPageCount.value = value;
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
          italicText("Kralın Dönüşü kitabı ${controller.bookPageCount.value.toInt()} sayfa. Siz ${controller.bookCurrentlyPage.value.toInt()}. sayfada kalmıştınız."),
          const SizedBox(height: 12,),
          Row(
            children: [
              RichTextWidget(
                  texts: ["Eski\nSayfanız\n","${controller.bookCurrentlyPage.value.toInt()}"],
                  colors: [Theme.of(context).colorScheme.secondary],
                  fontFamilies: const ["FontMedium","FontBold"],
                  align: TextAlign.center,
                fontSize: 14,
              ),
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: Slider(
                    value:  controller.sliderBookPageCount.value,
                    min: controller.bookCurrentlyPage.value+1,
                    max: controller.bookPageCount.value,
                    divisions: (controller.bookPageCount.value - (controller.bookCurrentlyPage.value+1)).toInt(),
                    label: controller.sliderBookPageCount.value.toInt().toString(),
                    onChanged: _updatePageCount,
                    activeColor: colors.blue,
                    inactiveColor: Theme.of(context).colorScheme.inverseSurface,
                    onChangeEnd: (value) {
                      controller.setLogNewCurrentPage(controller.sliderBookPageCount.value.toInt());
                    },
                  ),
                ),
              ),
              RichTextWidget(
                texts: ["Yeni\nSayfanız\n",(controller.sliderBookPageCount.value.toInt().toString())],
                colors: [Theme.of(context).colorScheme.inversePrimary],
                fontFamilies: const ["FontMedium","FontBold"],
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
    return RegularText(
      texts: text,
      size: "s",
      style: FontStyle.italic,
      maxLines: 3,
    );
  }
}