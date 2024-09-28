import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/circular_bar.dart';
import 'package:okuur/ui/components/rich_text.dart';

class MonthlyReadingInfo extends StatefulWidget {

  final int finishedPage;
  final int goalPage;

  const MonthlyReadingInfo({
    Key? key,
    required this.finishedPage,
    required this.goalPage,
  }) : super(key: key);

  @override
  State<MonthlyReadingInfo> createState() => _MonthlyReadingInfoState();
}

class _MonthlyReadingInfoState extends State<MonthlyReadingInfo> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Aylık Okuma",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primaryContainer),),
              InkWell(
                onTap: () {

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(50))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  child: Text("Ağustos 2024",style: TextStyle(color: colors.grey),),
                ),
              )
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichTextWidget(
                  texts: ["Okunan\n",widget.finishedPage.toString(),"\nSayfa"],
                  colors: [Theme.of(context).colorScheme.inversePrimary],
                  fontFamilies: const ["FontMedium","FontBold","FontMedium"]
              ),
              OkuurCircularProgressBar(
                size: 120,
                percentage: (widget.finishedPage/widget.goalPage),
                textColor: colors.blue,
                inSideColor: colors.grey,
                outSideColor: colors.blue,
              ),
              RichTextWidget(
                  texts: ["Hedef\n",widget.goalPage.toString(),"\nSayfa"],
                  colors: [Theme.of(context).colorScheme.secondary],
                  fontFamilies: const ["FontMedium","FontBold","FontMedium"],
                  align: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Text("Hedefin için günde en az 50 sayfa okumalısın. ",style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.secondary),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}