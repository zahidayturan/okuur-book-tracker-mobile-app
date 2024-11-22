import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/routes/bookDetail/book_detail.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/page_switcher.dart';
import 'package:okuur/ui/components/rich_text.dart';

class CurrentBookAndDiscover extends StatefulWidget {

  //get BookInfo

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

  int calculateRate(int page,int currentPage){
    if(page > 0 && (currentPage < page)){
      return ((currentPage / page)*100).toInt();
    }else if(currentPage >= page){
      return 100;
    } else{
      return 0;
    }
  }

  Widget bookInfo(List<OkuurBookInfo> list){
    return InkWell(
      onTap: () {
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
        );
      },
      child: SizedBox(
        height: 104,
        child: list.isNotEmpty ? PageView.builder(
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (value) async {
            setState(() {
              currentPage = value;
            });

            int tempData0 = list[value].currentPage;
            setState(() {
              list[value].currentPage = 0;
            });

            await Future.delayed(const Duration(milliseconds: 1000));
            setState(() {
              list[value].currentPage = tempData0;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
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
                              width: 68,
                              height: 96,
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
                                  textInfo(list[index].name, Theme.of(context).colorScheme.secondary, 14, "FontBold",TextAlign.start,2),
                                  textInfo(list[index].author, Theme.of(context).colorScheme.secondary, 12, "FontMedium",TextAlign.start,1),
                                  const Spacer(),
                                  textInfo("${list[index].currentPage}.sayfadasın / ${list[index].pageCount} sayfa", Theme.of(context).colorScheme.secondary, 11, "FontMedium",TextAlign.start,2),
                                  textInfo("Hedefin 12 günde bitirmek. 4/12", Theme.of(context).colorScheme.secondary, 11, "FontMedium",TextAlign.start,2),
                                  const Spacer(),
                                  textInfo("Başl. 22.08.2024", Theme.of(context).colorScheme.secondary, 11, "FontMedium",TextAlign.end,1)
                                ],
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            //double outerContainerHeight = constraints.maxHeight;
                            int rate = calculateRate(list[index].pageCount,list[index].currentPage);
                            double innerContainerHeight = 80 * (rate/100);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                textInfo("%${rate.toString()}", Theme.of(context).colorScheme.primary, 11, "FontMedium",TextAlign.center,1),
                                const SizedBox(height: 3,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 12,
                                    height: 80,
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
                                ),
                              ],
                            );
                          },
                        ),
                      ]),
                ],
              ),
            );
        } ) :
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: textInfo("Bir kitabı okumuyorsunuz. Yeni kitap ekleyin veya eklediklerinizden birini okumaya başlayın",Theme.of(context).colorScheme.secondary,13,"FontMedium",TextAlign.center,4),
          ),
        ),
      ),
    );
  }

  Text textInfo(String text,Color color,double size, String family, TextAlign align,int maxLines){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),textAlign: align,overflow: TextOverflow.ellipsis,maxLines: maxLines,
    );
  }

  Widget loadingBox() {
    return const SizedBox(height: 104,
      child: Center(
        child: Text(
            "Kitaplar yükleniyor..."
        ),
    ),);
  }
}