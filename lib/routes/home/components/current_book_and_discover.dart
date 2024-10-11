import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/page_switcher.dart';
import 'package:okuur/ui/components/popup_operation_menu.dart';
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => controller.booksLoading.value
            ? loadingBox()
            : bookInfo(controller.currentlyReadBooks)
      ),
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

  Column bookInfo(List<OkuurBookInfo> list){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextWidget(texts: ["Okuyorsun"," (${list.length})"],
                colors: [Theme.of(context).colorScheme.inversePrimary],
                fontFamilies: ["FontBold","FontMedium"],
                fontSize: 14),
            OkuurPageSwitcher(pageCount: list.length,currentPage: currentPage,)
          ],
        ),
        const SizedBox(height: 12,),
        SizedBox(
          height: 146,
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
                          textInfo(list[index].name, Theme.of(context).colorScheme.secondary, 15, "FontBold",TextAlign.start,2),
                          textInfo(list[index].author, Theme.of(context).colorScheme.secondary, 12, "FontMedium",TextAlign.start,1),
                          const SizedBox(height: 8,),
                          SizedBox(
                            height: 96,
                            child: Row(
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
                                const SizedBox(width: 12,),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textInfo("${list[index].currentPage}.sayfadasın\n${list[index].pageCount} sayfa", Theme.of(context).colorScheme.secondary, 12, "FontMedium",TextAlign.start,2),
                                      textInfo("Hedefin 12 günde bitirmek\n4/12", Theme.of(context).colorScheme.secondary, 12, "FontMedium",TextAlign.start,2),
                                      textInfo("Başl. 22.08.2024", Theme.of(context).colorScheme.secondary, 11, "FontMedium",TextAlign.end,1)
                                    ],
                                  ),
                                ),

                              ],
                            ),
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
                              double innerContainerHeight = 90 * (rate/100);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  textInfo("%${rate.toString()}", Theme.of(context).colorScheme.primary, 11, "FontMedium",TextAlign.center,1),
                                  const SizedBox(height: 2,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 12,
                                      height: 90,
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
                          const SizedBox(height: 6,),
                          moreButton()
                        ]),
                  ],
                ),
              );
          } ) :
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: textInfo("Bir kitabı okumuyorsunuz. Yeni kitap ekleyin veya eklediklerinizden birini okumaya başlayın",colors.black,14,"FontMedium",TextAlign.center,4),
            ),
          ),
        )
      ]
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

  InkWell moreButton(){
    return InkWell(
      onTapDown: (TapDownDetails details) {
        showOkuurPopupMenu(details.globalPosition, Theme.of(context).colorScheme.onPrimaryContainer, 12,[
          PopupMenuItem(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.slideshow_rounded,color: Theme.of(context).colorScheme.primaryContainer,size: 16),
                const SizedBox(width: 6),
                Text('Görüntüle',style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.primaryContainer),),
              ],
            ),
          ),
        ]);
      },
      child: Container(
        height: 11,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 3),
        child: Image.asset("assets/icons/more.png",color: Theme.of(context).primaryColor,),
      ),
    );
  }

  Widget loadingBox() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextWidget(texts: ["Okuyorsun"," (...)"],
                colors: [Theme.of(context).colorScheme.inversePrimary],
                fontFamilies: ["FontBold","FontMedium"],
                fontSize: 14),
          ],
        ),
        const SizedBox(height: 64),
        const SizedBox(height:32,width:32,child: CircularProgressIndicator()),
        const SizedBox(height: 62,child: Text(
            "Kitaplar yükleniyor..."
        ),),
      ],
    );
  }
}