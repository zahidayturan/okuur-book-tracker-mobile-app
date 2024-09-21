import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
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

  @override
  @override
  void initState() {
    super.initState();
    initAsync();
  }

  Future<void> initAsync() async {
    String? tempData0 = tempData[0]["currentPage"];

    setState(() {
      tempData[0]["currentPage"] = "0";
    });

    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      tempData[0]["currentPage"] = tempData0!;
    });
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
        child: bookInfo(),
      ),
    );
  }

  List<Map<String,String>> tempData = [
    {
      "bookName":"Kralın Dönüşü",
      "page":"360",
      "currentPage":"148",
    },
    {
      "bookName":"İki Kule",
      "page":"396",
      "currentPage":"372",
    }
  ];

  int calculateRate(int page,int currentPage){
    if(page > 0 && (currentPage < page)){
      return ((currentPage / page)*100).toInt();
    }else if(currentPage > page){
      return 100;
    } else{
      return 0;
    }
  }

  Column bookInfo(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextWidget(texts: ["Okuyorsun"," (${tempData.length})"],
                colors: [Theme.of(context).colorScheme.inversePrimary],
                fontFamilies: ["FontBold","FontMedium"],
                fontSize: 14),
            OkuurPageSwitcher(pageCount: tempData.length,currentPage: currentPage,)
          ],
        ),
        const SizedBox(height: 12,),
        SizedBox(
          height: 145,
          child: PageView.builder(
            itemCount: tempData.length,
            onPageChanged: (value) async {
              setState(() {
                currentPage = value;
              });

              String? tempData0 = tempData[value]["currentPage"];
              setState(() {
                tempData[value]["currentPage"] = "0";
              });

              await Future.delayed(const Duration(milliseconds: 1000));
              setState(() {
                tempData[value]["currentPage"] = tempData0!;
              });
            },
            itemBuilder: (context, index) {
              List<Map<String,String>> item = tempData;
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textInfo("${item[index]["bookName"]}", Theme.of(context).colorScheme.secondary, 15, "FontBold",TextAlign.start,2),
                          textInfo("J.R.R. Tolkien", Theme.of(context).colorScheme.secondary, 12, "FontMedium",TextAlign.start,1),
                          const SizedBox(height: 8,),
                          SizedBox(
                            height: 96,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 68,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(6))
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textInfo("148.sayfadasın\n360 sayfa", Theme.of(context).colorScheme.secondary, 12, "FontMedium",TextAlign.start,2),
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
                              int rate = calculateRate(int.parse(item[index]["page"]!),int.parse(item[index]["currentPage"]!));
                              double innerContainerHeight = 90 * (rate/100);
                              return Column(
                                children: [
                                  textInfo("%${rate.toString()}", Theme.of(context).colorScheme.primary, 11, "FontMedium",TextAlign.center,1),
                                  const SizedBox(height: 2,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      width: 22,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.easeInOut,
                                          width: 22,
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
          },),
        )
      ],

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
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 3),
        child: Image.asset("assets/icons/more.png",color: Theme.of(context).primaryColor,),
      ),
    );
  }
}