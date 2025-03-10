import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import '../../../ui/components/rich_text.dart';

class LogReadingTimeInfo extends StatefulWidget {
  const LogReadingTimeInfo({Key? key,}) : super(key: key);

  @override
  State<LogReadingTimeInfo> createState() => _LogReadingTimeInfoState();
}

class _LogReadingTimeInfoState extends State<LogReadingTimeInfo> {
  AppColors colors = AppColors();

  final AddLogController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Obx(() => Visibility(
      visible: controller.logNewCurrentPage.value != null,
      child: Column(
        children: [
          const SizedBox(height: 12,),
          formContent(),
        ],
      ),
    ));
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
            texts: ["${controller.bookReadingPageCount.value} Sayfayı ","Kaç Dakikada ","Okudunuz"],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: const ["FontMedium","FontBold","FontMedium"],
          ),
          const Row(
            children: [
              SizedBox(height: 8,),
            ],
          ),
          italicText("Önceki kayıtlara göre bir sayfa ortalama 1.5 dakikada okunmuş. (${controller.bookReadingPageCount.value} sayfa için ${(controller.bookReadingPageCount.value*1.5).toInt()} dakika)"),
          const SizedBox(height: 12,),
          Row(
            children: [
              alreadyButton(0,(controller.bookReadingPageCount.value*1.5).toInt()),
              const SizedBox(width: 12,),
              optionalButton(1)
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



  Widget alreadyButton(int index,int minute){
    return GestureDetector(
        onTap: () {
          setState(() {
            controller.logReadingTimeSelectedButton = index;
            controller.logReadingTimeController.clear();
            controller.setLogReadingTime(minute);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: controller.logReadingTimeSelectedButton == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(100))
          ),
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
          child: Text("$minute Dakika",style: TextStyle(color: controller.logReadingTimeSelectedButton == index ? colors.grey : Theme.of(context).colorScheme.secondary),),
        )
    );
  }

  Widget optionalButton(int index){
    return AnimatedContainer(
        height: 38,
        width: 108,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            color: controller.logReadingTimeSelectedButton == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(100))
        ),
      child: TextFormField(
          onTap: () {
            setState(() {
              controller.logReadingTimeSelectedButton = index;
              //controller.clearLogReadingTime();
            });
          },
          maxLength: 4,
          controller: controller.logReadingTimeController,
          keyboardType: TextInputType.number,
          inputFormatters:  <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ] ,
          decoration: InputDecoration(
            hintText: "Dakika Gir",
            counterText: "",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
                color: controller.logReadingTimeSelectedButton == index ? colors.grey : Theme.of(context).colorScheme.secondary,
            ),
            contentPadding: const EdgeInsets.only(bottom: 12),
            border: InputBorder.none,
            suffix: controller.logReadingTimeController.text.isNotEmpty ? const Text("Dakika") : null
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: controller.logReadingTimeSelectedButton == index ? colors.grey : Theme.of(context).colorScheme.secondary,
          ),
          onChanged: (value) {
            if(value.isNotEmpty && int.parse(value) > 0){
              controller.logReadingTimeSelectedButton = 1;
              controller.setLogReadingTime(int.parse(value));
            }else{
              controller.logReadingTimeSelectedButton = 0;
              controller.setLogReadingTime((controller.bookReadingPageCount.value*1.5).toInt()); //bug
              controller.logReadingTimeController.clear();
            }
            setState(() {});
          },
        onFieldSubmitted: (value) {
          if(value.isNotEmpty && int.parse(value) > 0){
            controller.logReadingTimeSelectedButton = 1;
            controller.setLogReadingTime(int.parse(value));
          }else{
            controller.logReadingTimeSelectedButton = 0;
            controller.setLogReadingTime((controller.bookReadingPageCount.value*1.5).toInt()); //bug
            controller.logReadingTimeController.clear();
          }
          setState(() {});
        },
      )
    );
  }
}