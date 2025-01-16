import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/routes/bookDetail/book_detail.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/page_switcher.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/shimmer_box.dart';
import 'package:okuur/ui/utils/date_formatter.dart';
import 'package:okuur/ui/utils/simple_calc.dart';

class CurrentBookAndDiscover extends StatefulWidget {

  const CurrentBookAndDiscover({
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentBookAndDiscover> createState() => _CurrentBookAndDiscoverState();
}

class _CurrentBookAndDiscoverState extends State<CurrentBookAndDiscover> {

  AppColors colors = AppColors();
  int currentPage = 0;
  HomeController controller = Get.find();
  BookDetailController bookDetailController = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchCurrentlyReadBooks().then((value) => initAsync());
  }

  Future<void> initAsync() async {
    if(controller.currentlyReadBooks.isNotEmpty){
      int tempData0 = controller.currentlyReadBooks[0].currentPage;

      setState(() {
        controller.currentlyReadBooks[0].currentPage = 0;
      });

      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        controller.currentlyReadBooks[0].currentPage = tempData0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.booksLoading.value
    ? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichTextWidget(texts: const ["Okuyorsun"," (..)"],
                colors: [Theme.of(context).colorScheme.secondary],
                fontFamilies: const ["FontBold","FontMedium"],
                fontSize: 14),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: loadingBox()
          ),
        ),
      ],
    ): Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichTextWidget(texts: ["Okuyorsun"," (${controller.currentlyReadBooks.length})"],
                colors: [Theme.of(context).colorScheme.secondary],
                fontFamilies: const ["FontBold","FontMedium"],
                fontSize: 14),
            OkuurPageSwitcher(pageCount: controller.currentlyReadBooks.length,currentPage: currentPage,)
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child:  bookInfo(controller.currentlyReadBooks)
              ),
            ),
      ],
    )
    );
  }

  int tempData0 = 0;
  Widget bookInfo(List<OkuurBookInfo> list){
    return SizedBox(
      height: 110,
      child: list.isNotEmpty ? PageView.builder(
        itemCount: list.length,
        onPageChanged: (value) async {
          setState(() {
            currentPage = value;
          });

          tempData0 = list[value].currentPage;
          setState(() {
            list[value].currentPage = 0;
          });

          await Future.delayed(const Duration(milliseconds: 1000));
          setState(() {
            list[value].currentPage = tempData0;
          });
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if(tempData0 != 0){
                list[index].currentPage = tempData0;
              }
              bookDetailController.setBookInfo(list[index]);
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, animation, nextanim) => const BookDetailPage(),
                  reverseTransitionDuration: const Duration(milliseconds: 1),
                  transitionsBuilder: (context, animation, nexttanim, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              ).then((result) {
                if (result == true) {
                  controller.fetchCurrentlyReadBooks().then((value) => initAsync());
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              height: 102,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                border: Border.all(width: 1,color: Theme.of(context).scaffoldBackgroundColor)
                              ),
                              child: imageShower(list[index].imageLink)
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 96,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RegularText(texts:list[index].name, family: "FontBold",maxLines: 2),
                                  RegularText(texts:list[index].author, size: "s"),
                                  const Spacer(),
                                  RegularText(texts:"${list[index].currentPage}.sayfadasın / ${list[index].pageCount} sayfa", size: "xs", maxLines: 2),
                                  const RegularText(texts:"Hedefin ? günde bitirmek. ?/?", size: "xs", maxLines: 2),
                                  const Spacer(),
                                  RegularText(texts:"Başl. ${OkuurDateFormatter.convertDate(list[index].startingDate)}", size: "xs", align:TextAlign.end)
                                ],
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      //double outerContainerHeight = constraints.maxHeight;
                      int rate = OkuurCalc.calcPercentage(list[index].pageCount,list[index].currentPage).toInt();
                      double innerContainerHeight = 96 * (rate/100);
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          width: 10,
                          height: 102,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut,
                              width: 12,
                              height: innerContainerHeight,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
      } ) :
      const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: RegularText(texts: "Bir kitabı okumuyorsunuz. Yeni kitap ekleyin veya eklediklerinizden birini okumaya başlayın",size:"m",align:TextAlign.center,maxLines: 4),
        ),
      ),
    );
  }



  Widget loadingBox() {
    return const ShimmerBox(height: 110,borderRadius: BorderRadius.all(Radius.circular(8)));
  }
}