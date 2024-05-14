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
            height: 180,
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
        SizedBox(width: 12,),
        Container(
          height: 180,
          width: 96,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: colors.white
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 28,top: 40),
                child: Image.asset("assets/icons/connection.png",color: colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: discoverInfo(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column bookInfo(){
    return Column(

    );
  }

  Column discoverInfo(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        textInfo("Keşfet", colors.greenDark, 15, "FontBold",TextAlign.end),
        textInfo("Okuyacak\nyeni\nkitaplar\nbul", colors.green, 13, "FontMedium",TextAlign.end),
        Center(
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: colors.greenDark
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset("assets/icons/line_arrow.png"),
            ),
          ),
        )
      ],

    );
  }

  Text textInfo(String text,Color color,double size, String family, TextAlign align){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),textAlign: align,overflow: TextOverflow.ellipsis,
    );
  }

}