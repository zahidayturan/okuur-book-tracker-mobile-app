import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/routes/bookDetail/components/book_detail_edit.dart';
import 'package:okuur/routes/bookDetail/components/book_detail_loading.dart';
import 'package:okuur/routes/bookDetail/components/book_goal_info.dart';
import 'package:okuur/routes/bookDetail/components/book_points_info.dart';
import 'package:okuur/routes/bookDetail/components/book_records_detail.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/functional_alert_dialog.dart';
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
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, controller.isLogChanged.value);
          return false;
        },
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
        startReading(controller.okuurBookInfo!),
        totalRead(controller.okuurBookInfo!),
        const SizedBox(height: 18,),
        bookState(controller.okuurBookInfo!),
        bookGoal(),
        const SizedBox(height: 18,),
        const BookRecordsDetail(),
        const SizedBox(height: 18,),
        bookPoints(context, controller.okuurBookInfo!)
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
              popButton(context,controller.isLogChanged.value),
              const SizedBox(height: 8),
              RegularText(
                  texts: okuurBookInfo.name,
                  size: "xl",
                  maxLines: 2,
                  weight: FontWeight.w700),
              RegularText(
                  texts: okuurBookInfo.author,
                  size: "m",
              ),
              RegularText(
                texts: "${okuurBookInfo.type} - ${okuurBookInfo.pageCount} sayfa",
                size: "m",
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.editInit(okuurBookInfo);
                      showBookDetailEditDialog(context,okuurBookInfo);
                    },
                    child: TextIconButton(
                      text: "Düzenle",
                      icon: Icons.edit_rounded,
                      backColor: Theme.of(context).colorScheme.secondary,
                      iconColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () async {
                      bool shouldExit = await _showCustomDialog("Kitap ve kayıtları silinecek!\nEmin misiniz?","Sil");
                      if (shouldExit) {
                        controller.deleteBook(okuurBookInfo);
                      }
                    },
                    child: TextIconButton(
                        text: "Sil",
                        icon: Icons.delete_outline_rounded,
                        iconColor: colors.red),
                  )
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

  Widget bookState(OkuurBookInfo okuurBookInfo){
    int rate = OkuurCalc.calcPercentage(okuurBookInfo.pageCount,okuurBookInfo.currentPage).toInt();
    bool isNotStarted = okuurBookInfo.status == 0;
    return Visibility(
      visible: !isNotStarted,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: BaseContainer(
          radius: 12,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RegularText(texts: rate < 100 ? "Bu Kitabı Okuyorsun" : "Bu Kitabı Okudun",style: FontStyle.italic),
                  RegularText(texts: rate < 100 ? "${okuurBookInfo.currentPage}. sayfadasın" : "Bitti",size: "m")
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
        ),
      ),
    );
  }

  Widget startReading(OkuurBookInfo okuurBookInfo){
    bool isNotStarted = okuurBookInfo.status == 0;
    bool isReading = okuurBookInfo.status % 2 == 1;
    return Visibility(
      visible: isNotStarted || !isReading,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: InkWell(
          onTap: () async {
            bool shouldExit = await _showCustomDialog("Kitabı okumaya\nbaşlayacak mısınız?","Evet");
            if (shouldExit) {
              controller.updateBookStatus(okuurBookInfo,isNotStarted);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: TextIconButton(
            icon: isNotStarted ? Icons.not_started_rounded : Icons.restart_alt_rounded,
            text: isNotStarted ? "Kitabı Okumaya Başla" : "Yeniden Okumaya Başla",
            iconColor: colors.grey,
            height: 54,
            radius: 12,
            backColor: isNotStarted ? Theme.of(context).colorScheme.secondaryContainer : colors.green,
          ),
        ),
      ),
    );
  }

  Widget totalRead(OkuurBookInfo okuurBookInfo){
    int totalReading = okuurBookInfo.totalReading;
    String points = ((2 * okuurBookInfo.readingTime * totalReading) / (okuurBookInfo.readingTime + (totalReading+1))).toStringAsFixed(0);

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
              iconAndText("assets/icons/page.png", "sayfa",totalReading.toString()),
              iconAndText("assets/icons/clock.png", "dakika",okuurBookInfo.readingTime.toString()),
              iconAndText("assets/icons/point.png", "puan",points),
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

  Future<bool> _showCustomDialog(String text,String confirmText) async {
    bool? result = await OkuurAlertDialog.show(
      context: context,
      contentText: text,
      buttons: [
        AlertButton(text: "Geri Dön", fill: false, returnValue: false),
        AlertButton(text: confirmText, fill: true, returnValue: true),
      ],
    );
    return result ?? false;
  }
}