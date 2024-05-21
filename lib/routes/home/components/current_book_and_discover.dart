import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 168,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: bookInfo(),
            ),
          ),
        ),
      ],
    );
  }

  Column bookInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textInfo("Okuyorsun", colors.greenDark, 14, "FontBold",TextAlign.start,1),
            textInfo("Başl. 22.08.2024", colors.black, 11, "FontMedium",TextAlign.end,1),
          ],
        ),
        textInfo("Kralın Dönüşü", colors.black, 15, "FontMedium",TextAlign.start,2),
        textInfo("J.R.R. Tolkien", colors.black, 12, "FontMedium",TextAlign.start,1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colors.blueLight,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4)
                      )

                    ),
                  ),
                ),
                Container(
                  width: 54,
                  height: 76,
                  margin: EdgeInsets.only(left: 4,bottom: 4),
                  decoration: BoxDecoration(
                    color: colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textInfo("148.sayfadasın / 240", colors.green, 11, "FontMedium",TextAlign.end,1),
                      SizedBox(width: 4,),
                      Container(
                        width: 5,
                        height: 12,
                        decoration: BoxDecoration(
                          color: colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  textInfo("4 gündür okuyorsun", colors.black, 11, "FontMedium",TextAlign.end,1),
                  RichTextWidget(
                      texts: ["Hedefin ","12 günde ","bitirmek"],
                      colors: [colors.black,colors.black,colors.black],
                      fontFamilies: ["FontMedium","FontBold","FontMedium"],
                      fontSize: 11,
                      align: TextAlign.end),
                  Spacer(),
                  Container(
                    height: 18,
                    decoration: BoxDecoration(
                      color: colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Center(child: textInfo("İşlem menüsü", colors.white, 11, "FontMedium",TextAlign.end,1)),
                    ),
                  )
                ],
              ),
            )
          ],
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
}