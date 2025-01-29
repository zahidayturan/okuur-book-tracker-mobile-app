import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/page_header.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/const/month_name_list.dart';

class ReadingSeriesPage extends StatefulWidget {
  const ReadingSeriesPage({super.key});

  @override
  State<ReadingSeriesPage> createState() => _ReadingSeriesPageState();
}

class _ReadingSeriesPageState extends State<ReadingSeriesPage> {

  AppColors colors = AppColors();
  HomeController controller = Get.find();

  @override
  void initState() {
    controller.resetMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  PageHeaderTitle(
                      title: "Okuma Serin",
                      pathName: "assets/icons/time.png",
                      subtitle: "",
                      backButton: true
                  ).getTitle(context),
                  BaseContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RegularText(texts: "Aktif\nOkuma Serin",maxLines: 2,size: "xl"),
                        BaseContainer(
                            height: 54,
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            child: Center(child: Row(
                              children: [
                                RegularText(texts: "34",color: colors.grey,size: "xxl",weight: FontWeight.bold,),
                                const SizedBox(width: 4,),
                                RegularText(texts: "Gün",color: colors.grey,size: "xl")
                              ],
                            )))
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  BaseContainer(child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.decrementMonth();

                            },
                            child: const SizedBox(height:24,width:24,child: Icon(Icons.arrow_back_ios_rounded)),
                          ),
                          Obx(() => InkWell(
                            onLongPress: () {
                              controller.resetMonth();
                            },
                            child: RegularText(
                              texts: "${months[controller.seriesMonth.value.month]} ${controller.seriesMonth.value.year}",
                              size: "xl", weight: FontWeight.bold,
                            ),
                          )),
                          InkWell(
                            onTap: () {
                              controller.incrementMonth();
                            },
                            child: const SizedBox(height:24,width:24,child: Icon(Icons.arrow_forward_ios_rounded)),
                          ),
                        ],
                      ),
                      BaseContainer(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Center(child: RegularText(texts: "Pzt",color: colors.greyLight))),
                                  Expanded(child: Center(child: RegularText(texts: "Sal",color: colors.greyLight))),
                                  Expanded(child: Center(child: RegularText(texts: "Çar",color: colors.greyLight))),
                                  Expanded(child: Center(child: RegularText(texts: "Per",color: colors.greyLight))),
                                  Expanded(child: Center(child: RegularText(texts: "Cum",color: colors.greyLight))),
                                  Expanded(child: Center(child: RegularText(texts: "Cmt",color: colors.greyLight))),
                                  Expanded(child: Center(child: RegularText(texts: "Pzr",color: colors.greyLight)))
                                ],
                              ),
                              Obx(() => SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  itemCount: controller.getDaysInMonth().keys.length,
                                  itemBuilder: (context, weekIndex) {
                                    int week = weekIndex + 1;
                                    List<Map<String, dynamic>> weekDays = controller.getDaysInMonth()[week]!;
                                    return Row(
                                      children: weekDays.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        Map<String, dynamic> dayMap = entry.value;

                                        bool isFirst = index == 0;
                                        bool isLast = index == weekDays.length - 1;

                                        return Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4),
                                            child: Container(
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: dayMap['series'] == true
                                                    ? Theme.of(context).colorScheme.secondaryContainer
                                                    : null,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: isFirst ? const Radius.circular(50) : Radius.zero,
                                                  topRight: isLast ? const Radius.circular(50) : Radius.zero,
                                                  bottomLeft: isFirst ? const Radius.circular(50) : Radius.zero,
                                                  bottomRight: isLast ? const Radius.circular(50) : Radius.zero,
                                                ),
                                              ),
                                              child: Center(
                                                child: RegularText(
                                                  texts: dayMap['day'],
                                                  color: colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              )),

                            ],
                          ))
                    ],
                  )),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}