import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          RegularText(texts: "Kralın Dönüşü kitabı ${controller.bookPageCount.value.toInt()} sayfa. Siz ${controller.bookCurrentlyPage.value.toInt()}. sayfada kalmıştınız.",
              size: "s",style: FontStyle.italic,maxLines: 3),
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
              Column(
                children: [
                  RegularText(texts: "Yeni\nSayfanız",color: Theme.of(context).colorScheme.inversePrimary,align: TextAlign.center,maxLines: 2),
                  SizedBox(
                    height: 20,
                    width: 50,
                    child: TextFormField(
                      controller: controller.logNewCurrentPageController,
                      onTap: () {
                        setState(() {});
                      },
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: (controller.bookCurrentlyPage.value + 1).toStringAsFixed(0),
                        counterText: "",
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 12),
                        border: const UnderlineInputBorder(),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontFamily: "FontBold"
                      ),
                      onFieldSubmitted: (value) {
                        _handleInputValidation(value);
                      },
                      onTapOutside: (event) {
                        if(FocusScope.of(context).hasFocus){
                          _handleInputValidation(controller.logNewCurrentPageController.text);
                          FocusScope.of(context).unfocus();
                        }
                      }
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _handleInputValidation(String value) {
    if (value.isNotEmpty &&
        (int.parse(value) > controller.bookCurrentlyPage.value) &&
        (int.parse(value) <= controller.bookPageCount.value)) {
      controller.setLogNewCurrentPage(int.parse(value));
    } else {
      controller.setLogNewCurrentPage((controller.bookCurrentlyPage.value + 1).toInt());
    }
  }
}