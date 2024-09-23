import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import '../../../ui/components/rich_text.dart';

class LogReadingTimeInfo extends StatefulWidget {
  const LogReadingTimeInfo({Key? key,}) : super(key: key);

  @override
  State<LogReadingTimeInfo> createState() => _LogReadingTimeInfoState();
}

class _LogReadingTimeInfoState extends State<LogReadingTimeInfo> {
  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

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
              alreadyButton(),
              SizedBox(width: 12,),
              optionalButton()
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

  Widget alreadyButton(){
    return GestureDetector(
        onTap: () {

        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: const BorderRadius.all(Radius.circular(100))
          ),
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
          child: Text("63 Dakika",style: TextStyle(color: colors.grey),),
        )
    );
  }

  Widget optionalButton(){
    return GestureDetector(
        onTap: () {

        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(100))
          ),
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
          child: Text("Dakika Gir",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
        )
    );
  }
}