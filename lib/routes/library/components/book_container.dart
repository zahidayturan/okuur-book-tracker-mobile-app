import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

AppColors colors = AppColors();
Container bookContainer(){
  return Container(
    decoration: BoxDecoration(
      color: colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8))
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text("Şu an okuyorsun", colors.orange, 13, "FontMedium", 1,FontWeight.normal),
            text("%74", colors.orange, 13, "FontMedium", 1,FontWeight.w700),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58,
              height: 90,
              decoration: BoxDecoration(
                color: colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.network(
                  'https://picsum.photos/250?image=8',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: SizedBox(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    text("Kralın Dönüşü", colors.black, 15, "FontMedium", 2,FontWeight.bold),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("J.R.R. Tolkien", colors.black, 13, "FontMedium", 1,FontWeight.normal),
                        text("Roman - 240 sayfa", colors.black, 12, "FontMedium", 1,FontWeight.normal),
                        const SizedBox(height: 2,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text("8.09.2024 / 4 gündür okuyorsun", colors.black, 11, "FontMedium", 1,FontWeight.normal),
                        moreButton(true)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Text text(String text,Color color,double size, String family,int maxLines,FontWeight? weight){
  return Text(
    text,style: TextStyle(
      color: color,
      fontFamily: family,
      fontWeight: weight,
      fontSize: size
  ),overflow: TextOverflow.ellipsis,maxLines: maxLines,
  );
}

InkWell moreButton(bool isReading){
  return InkWell(
    onTap: () {

    },
    child: Container(
      height: 11,
      decoration: BoxDecoration(
        color: isReading ? colors.orange : colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      padding: const EdgeInsets.all(2.3),
      child: Image.asset("assets/icons/more.png"),
    ),
  );
}