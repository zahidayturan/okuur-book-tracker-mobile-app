import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/slider_form.dart';
import 'package:okuur/ui/components/star_rating.dart';

AppColors colors = AppColors();
BookDetailController controller = Get.find();

Widget bookPoints(BuildContext context, OkuurBookInfo okuurBookInfo){
  int readingCount = okuurBookInfo.status ~/ 2;
  return Padding(
    padding: const EdgeInsets.only(bottom: 18.0),
    child: BaseContainer(
      radius: 12,
      padding: 0,
      child: Visibility(
        visible: okuurBookInfo.status > 1,
        child: Material(
          type: MaterialType.transparency,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              controller.bookRating.value = okuurBookInfo.rating*20;
              showBookPointEditDialog(context,okuurBookInfo);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const RegularText(texts: "Değerlendirme Puanın",style: FontStyle.italic),
                      RegularText(texts: "$readingCount defa bitirdin",size: "m")
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: OkuurStarRating(
                      rating: okuurBookInfo.rating,
                      filledStarColor: Theme.of(context).colorScheme.tertiary,
                      unfilledStarColor: colors.blue,
                      text: okuurBookInfo.rating.toString(),
                      vertical: false,
                      starSize: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void showBookPointEditDialog(BuildContext context,OkuurBookInfo okuurBookInfo) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    popButton(context,false),
                    const RegularText(texts: "Kitaba Puan Ver",size: "xl",)
                  ],
                ),
                const SizedBox(height: 12,),
                const RegularText(texts: "Kitaba 100 üzerinden bir puan verebilirsiniz. 5 sayısıyla oranlanacaktır.",size: "m",maxLines: 3),
                PageCountSelector(
                  minValue: 0,maxValue: 100,
                  currentValue: controller.bookRating.value,
                  textController: controller.textControllerForSlider,
                  onChanged: (int value) {
                  controller.setBookRating(double.parse((value/20).toStringAsFixed(1)));
                },
                ),
                const SizedBox(height: 4,),
                addButton(context, okuurBookInfo)
              ],
            ),
          ),
        ),
      );},
  );
}

Widget addButton(BuildContext context,OkuurBookInfo okuurBookInfo) {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            controller.updateBookPoint(okuurBookInfo);
          },
          child: Container(
            decoration: BoxDecoration(
              color: colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RegularText(
                    texts: "Puanı Kaydet",
                    color: colors.grey,size: "l"),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
