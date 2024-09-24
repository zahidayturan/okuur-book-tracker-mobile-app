import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
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
            texts: const ["42 Sayfayı ","Kaç Dakikada ","Okudunuz"],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: const ["FontMedium","FontBold","FontMedium"],
          ),
          const Row(
            children: [
              SizedBox(height: 8,),
            ],
          ),
          italicText("Önceki kayıtlarınıza göre bir sayfayı ortalama 1.5 dakikada okumuşsunuz. (42 sayfa için 63 dakika)"),
          const SizedBox(height: 12,),
          Row(
            children: [
              alreadyButton(0,63),
              const SizedBox(width: 12,),
              optionalButton(1)
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

  int selectedButtonIndex = 0;

  Widget alreadyButton(int index,int minute){
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedButtonIndex = index;
            controller.logReadingTimeController.clear();
            controller.setLogReadingTime(minute);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: selectedButtonIndex == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(100))
          ),
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
          child: Text("$minute Dakika",style: TextStyle(color: selectedButtonIndex == index ? colors.grey : Theme.of(context).colorScheme.secondary),),
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
            color: selectedButtonIndex == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(100))
        ),
      child: TextFormField(
          onTap: () {
            setState(() {
              selectedButtonIndex = index;
              controller.clearLogReadingTime();
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
                color: selectedButtonIndex == index ? colors.grey : Theme.of(context).colorScheme.secondary,
            ),
            contentPadding: const EdgeInsets.only(bottom: 12),
            border: InputBorder.none,
            suffix: controller.logReadingTimeController.text.isNotEmpty ? const Text("Dakika") : null
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: selectedButtonIndex == index ? colors.grey : Theme.of(context).colorScheme.secondary,
          ),
          onChanged: (value) {
            if(value.isNotEmpty){
                controller.setLogReadingTime(int.parse(value));
            }else{
              selectedButtonIndex = 0;
              controller.setLogReadingTime(63);
            }
            setState(() {});
          },
        onFieldSubmitted: (value) {
          setState(() {});
        },
      )
    );
  }
}