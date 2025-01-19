import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import '../../../ui/components/rich_text.dart';

class LogReadingDateInfo extends StatefulWidget {
  const LogReadingDateInfo({Key? key,}) : super(key: key);

  @override
  State<LogReadingDateInfo> createState() => _LogReadingDateInfoState();
}

class _LogReadingDateInfoState extends State<LogReadingDateInfo> {
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
                texts: const ["Hangi ","Gün ","Okudunuz"],
                colors: [Theme.of(context).colorScheme.secondary],
                fontFamilies: const ["FontMedium","FontBold","FontMedium"],
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              alreadyButton(0,"Bugün",DateTime.now()),
              const SizedBox(width: 12,),
              alreadyButton(1,"Dün",DateTime.now().subtract(const Duration(days: 1))),
              const SizedBox(width: 12,),
              optionalButton(2)
            ],
          )
        ],
      ),
    );
  }

  int selectedButtonIndex = 0;

  Widget alreadyButton(int index,String text,DateTime date){
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedButtonIndex = index;
            controller.logReadingDateController.clear();
            controller.setLogReadingDate(date);
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
          child: Text(text,style: TextStyle(color: selectedButtonIndex == index ? colors.grey : Theme.of(context).colorScheme.secondary),),
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
              controller.clearLogReadingDate();
            });
            _selectDate();
          },
          controller: controller.logReadingDateController,
          readOnly: true,
          decoration: InputDecoration(
              hintText: "Tarih Seç",
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

  Future<void> _selectDate() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
            ),
            child: child!,
          );
        },
        initialDate: DateTime.now(),
        firstDate:  DateTime.now().subtract(const Duration(days: 180)),
        lastDate: DateTime.now().add(const Duration(days: 1)),
      );

      if (pickedDate != null) {
        setState(() {
          controller.logReadingDateController.text = DateFormat('dd.MM.yyyy').format(pickedDate);
          controller.setLogReadingDate(pickedDate);
        });
      }else{
        setState(() {
          selectedButtonIndex = 0;
          controller.logReadingDateController.clear();
          controller.setLogReadingDate(DateTime.now());
        });
      }

  }
}