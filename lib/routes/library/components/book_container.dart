import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/components/star_rating.dart';
import 'package:okuur/ui/utils/date_formatter.dart';
import 'package:okuur/ui/utils/simple_calc.dart';

AppColors colors = AppColors();


Row bookContainerLibrary(OkuurBookInfo bookInfo,String index){
  bool isReading = bookInfo.status %2 == 1 ? true : false;
  return Row(
    children: [
      Expanded(
        child: Stack(
          alignment:  Alignment.centerLeft,
          children: [
            Container(
              width: 24,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24),),
                  color: isReading ? colors.orange : null
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: RotatedBox(
                    quarterTurns: 3,
                    child: Center(child: text(index,isReading ? colors.white : colors.greenDark,13,"FontBold",1,FontWeight.normal))),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(isReading ? "Şu an okuyorsun" : "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} - ${OkuurDateFormatter.convertDate(bookInfo.finishingDate)}", isReading ? colors.orange : colors.black, 13, "FontMedium", 1,FontWeight.normal),
                      text("%${OkuurCalc.calcPercentage(bookInfo.pageCount,bookInfo.currentPage)}", isReading ? colors.orange : colors.greenDark, 13, "FontMedium", 1,FontWeight.w700),
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
                              text(bookInfo.name, colors.black, 15, "FontMedium", 2,FontWeight.bold),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(bookInfo.author, colors.black, 13, "FontMedium", 1,FontWeight.normal),
                                  text("${bookInfo.type} - ${bookInfo.pageCount} sayfa", colors.black, 12, "FontMedium", 1,FontWeight.normal),
                                  const SizedBox(height: 2,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  text(isReading ? "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} / ${OkuurCalc.calcDaysBetween(bookInfo.startingDate, DateTime.now().toString())} gündür okuyorsun" : "${OkuurCalc.calcDaysBetween(bookInfo.startingDate,bookInfo.finishingDate)} günde okudunuz", colors.black, 11, "FontMedium", 1,FontWeight.normal),
                                  moreButton(isReading)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 4,),
      OkuurStarRating(rating: bookInfo.rating,filledStarColor:colors.greenDark,unfilledStarColor: isReading ? colors.blueLight :colors.blue,text: isReading ? "" : bookInfo.rating.toString(),)
    ],
  );
}

Text text(String text,Color color,double size, String family,int maxLines,FontWeight? weight){
  return Text(
    text,style: TextStyle(
      color: color,
      fontFamily: family,
      fontWeight: weight,
      fontSize: size,
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
        color: isReading ? colors.orange : colors.greenDark,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 3),
      child: Image.asset("assets/icons/more.png"),
    ),
  );
}