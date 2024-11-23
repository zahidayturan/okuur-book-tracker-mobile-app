import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';
import '../../../ui/components/rich_text.dart';

class LogFinishingHourInfo extends StatefulWidget {
  const LogFinishingHourInfo({Key? key,}) : super(key: key);

  @override
  State<LogFinishingHourInfo> createState() => _LogFinishingHourInfoState();
}

class _LogFinishingHourInfoState extends State<LogFinishingHourInfo> {
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
          Row(
            children: [
              RichTextWidget(
                texts: const ["Okumayı ","Saat Kaçta ","Bitirdiniz"],
                colors: [Theme.of(context).colorScheme.secondary],
                fontFamilies: const ["FontMedium","FontBold","FontMedium"],
              ),
            ],
          ),
          const Row(
            children: [
              SizedBox(height: 8,),
            ],
          ),
          italicText("Şimdi bitirdiyseniz ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} bitiş saati olarak kayıt edilecektir."),
          const SizedBox(height: 12,),
          Row(
            children: [
              alreadyButton(0,"${DateTime.now().hour}:${DateTime.now().minute}"),
              const SizedBox(width: 12,),
              optionalButton(2)
            ],
          )
        ],
      ),
    );
  }

  int selectedButtonIndex = 0;

  Widget alreadyButton(int index,String hour){
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedButtonIndex = index;
            controller.logFinishingHourController.clear();
            controller.setLogFinishingHour(hour);
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
          child: RegularText(texts: "Şimdi Bitirdim",color: selectedButtonIndex == index ? colors.grey : Theme.of(context).colorScheme.secondary),
        )
    );
  }

  Widget optionalButton(int index){
    return AnimatedContainer(
        height: 38,
        width: 112,
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
              controller.clearLogFinishingHour();
            });
            _selectHour();
          },
          controller: controller.logFinishingHourController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "Saat Seç",
            counterText: "",
            hintStyle: TextStyle(
              color: selectedButtonIndex == index ? colors.grey : Theme.of(context).colorScheme.secondary,
            ),
            contentPadding: const EdgeInsets.only(bottom: 12),
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: selectedButtonIndex == index ? colors.grey : Theme.of(context).colorScheme.secondary,
          ),
        )
    );
  }

  Future<void> _selectHour() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        String formattedTime = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
        controller.logFinishingHourController.text = formattedTime;
        controller.setLogFinishingHour(formattedTime);
      });
    } else {
      setState(() {
        String nowTime = "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}";
        controller.logFinishingHourController.clear();
        selectedButtonIndex = 0;
        controller.setLogFinishingHour(nowTime);
      });
    }
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