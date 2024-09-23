import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import '../../../ui/components/rich_text.dart';

class LogPageInfo extends StatefulWidget {
  const LogPageInfo({Key? key,}) : super(key: key);

  @override
  State<LogPageInfo> createState() => _LogPageInfoState();
}

class _LogPageInfoState extends State<LogPageInfo> {
  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

  final AddLogController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        formContent(),
      ],
    );
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