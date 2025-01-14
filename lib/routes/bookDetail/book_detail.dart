import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/routes/bookDetail/components/book_detail_loading.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/text_and_icon_button.dart';
import 'package:okuur/ui/utils/simple_calc.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  AppColors colors = AppColors();

  BookDetailController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getBookDetail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Obx(() => controller.detailLoading.value
                  ? bookDetailLoadingBox(context)
                  : bookDetail(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bookDetail(){
    return controller.okuurBookInfo == null
        ? Column(
      children: [
        const SizedBox(height: 12),
        Align(alignment:Alignment.topLeft,child: popButton(context)),
        const SizedBox(height: 8),
        const RegularText(texts: "Kitap bilgileri yüklenirken\nbir hata oluştu",maxLines: 6,size: "l",align: TextAlign.center,),
        const SizedBox(height: 18),
      ],
    )
      : Column(
      children: [
        const SizedBox(height: 12),
        bookMiniInfo(controller.okuurBookInfo!),
        const SizedBox(height: 18),
        totalRead(controller.okuurBookInfo!),
        const SizedBox(height: 18,),
        bookPageState(controller.okuurBookInfo!),
        const SizedBox(height: 18,),
        bookGoal(),
        const SizedBox(height: 18,),
        bookRecords(controller.logs),
        const SizedBox(height: 18,)
      ],
    );
  }

  Widget bookMiniInfo(OkuurBookInfo okuurBookInfo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 164,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              popButton(context),
              const SizedBox(height: 8),
              RegularText(
                  texts: okuurBookInfo.name,
                  size: "xl",
                  maxLines: 2,
                  weight: FontWeight.w700),
              RegularText(
                  texts: okuurBookInfo.author,
                  size: "m",
                  style: FontStyle.italic),
              RegularText(
                texts: "${okuurBookInfo.type} - ${okuurBookInfo.pageCount} sayfa",
                size: "m",
              ),
              const Spacer(),
              Row(
                children: [
                  TextIconButton(
                    text: "Düzenle",
                    icon: Icons.edit_rounded,
                    backColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  TextIconButton(
                      text: "Sil",
                      icon: Icons.delete_outline_rounded,
                      iconColor: colors.red)
                ],
              )
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
            width: 112,
            height: 164,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            child: imageShower(okuurBookInfo.imageLink)),
      ],
    );
  }

  Widget bookPageState(OkuurBookInfo okuurBookInfo){
    int rate = OkuurCalc.calcPercentage(okuurBookInfo.pageCount,okuurBookInfo.currentPage).toInt();
    return BaseContainer(
      radius: 12,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RegularText(texts: "Bu Kitabı Okuyorsun",style: FontStyle.italic),
              RegularText(texts: "${okuurBookInfo.currentPage}. sayfadasın",size: "m")
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              double outerContainerHeight = constraints.maxWidth;
              double innerContainerWidth = outerContainerHeight * (rate/100);
              return Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 18,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: innerContainerWidth,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  RegularText(texts:"%${rate.toString()}", color: Theme.of(context).colorScheme.inversePrimary,size:"m"),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget bookGoal(){
    return BaseContainer(
      radius: 12,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(texts: "Bitirme Hedefin",style: FontStyle.italic),
              RegularText(texts: "? gün",size: "m")
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              double outerContainerHeight = constraints.maxWidth;
              int rate = 0;
              double innerContainerWidth = outerContainerHeight * (rate/100);
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: innerContainerWidth,
                        decoration: BoxDecoration(
                          color: colors.orange,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RegularText(texts: "Başlangıç ?",size: "s"),
              RegularText(texts: "Kalan ? gün",size: "m",color: colors.orange,)
            ],
          ),
        ],
      ),
    );
  }
  int selectedItem = 0;

  Widget bookRecords(List<OkuurLogInfo> logs) {
    String parsedDate = "?";

    if(logs.isNotEmpty){
      List<String> dateParts = logs[selectedItem].readingDate.split('.');
      parsedDate = '${dateParts[0]}\n${dateParts[1]}';
    }

    return logs.isNotEmpty ? BaseContainer(
      radius: 12,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RegularText(texts: "Okumaların", style: FontStyle.italic),
              RegularText(texts: "${logs.length} kayıt", size: "m"),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: logs.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 400),
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedItem == index
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(selectedItem == index ? 16 : 8),
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    child: Center(
                      child: RegularText(
                        texts: parsedDate,
                        align: TextAlign.center,
                        size: "m",
                        maxLines: 3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          BaseContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RegularText(texts: "Seçili Okuma Detayı",style: FontStyle.italic,size: "m",),
                    Icon(Icons.info_outline_rounded,size: 16,color: Theme.of(context).colorScheme.secondary)
                  ],
                ),
                const SizedBox(height: 4),
                RegularText(texts: logs[selectedItem].readingDate),
                RegularText(texts: "${logs[selectedItem].numberOfPages} sayfa / ${logs[selectedItem].timeRead} dakika / ? puan"),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    opButton(
                      "Düzenle",
                      Icons.edit_rounded,
                      Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    opButton(
                        "Okuma Kaydını Sil",
                        Icons.delete_outline_rounded,
                        colors.red)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ) : const SizedBox();
  }


  Widget totalRead(OkuurBookInfo okuurBookInfo){
    return BaseContainer(
      radius: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RegularText(texts: "Toplam Okuma",style: FontStyle.italic),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconAndText("assets/icons/page.png", "sayfa",okuurBookInfo.currentPage.toString()),
              iconAndText("assets/icons/clock.png", "dakika",okuurBookInfo.readingTime.toString()),
              iconAndText("assets/icons/point.png", "puan","?"),
            ],),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Row iconAndText(String path,String text,String count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor
          ),
          padding: const EdgeInsets.all(5),
          child: Image.asset(path,color: Theme.of(context).colorScheme.secondary,),
        ),
        const SizedBox(width: 4,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(texts:count, color: Theme.of(context).colorScheme.secondary, size: "m"),
            RegularText(texts:text, color: Theme.of(context).colorScheme.secondary, size: "xs"),
          ],
        )
      ],
    );
  }

  Widget opButton(String text,IconData icon,Color iconColor){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      child: Row(
        children: [
          Icon(icon,size: 16,color: iconColor),
          const SizedBox(width: 4),
          RegularText(texts: text,color: iconColor,size: "m")
        ],
      ),
    );
  }
}
