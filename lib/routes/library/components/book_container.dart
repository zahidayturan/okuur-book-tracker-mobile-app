import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/components/popup_operation_menu.dart';
import 'package:okuur/ui/components/star_rating.dart';
import 'package:okuur/ui/utils/date_formatter.dart';
import 'package:okuur/ui/utils/simple_calc.dart';

AppColors colors = AppColors();


Row bookContainerLibrary(OkuurBookInfo bookInfo,String index){
  bool isNotStarted = bookInfo.status == 0;
  bool isReading = bookInfo.status %2 == 1;
  String percentage = OkuurCalc.calcPercentage(bookInfo.pageCount,bookInfo.currentPage);
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              isNotStarted ?
              const SizedBox()
                  :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                    text(index,isReading ? colors.orange : colors.black,13,"FontBold",1,FontWeight.normal),
                    Container(width: 4,height: 4,margin:const EdgeInsets.symmetric(horizontal: 4),decoration: BoxDecoration(shape: BoxShape.circle,color: isReading ? colors.orange : colors.black),),
                    text(isReading ? "Şu an okuyorsun" : "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} - ${OkuurDateFormatter.convertDate(bookInfo.finishingDate)}", isReading ? colors.orange : colors.black, 13, "FontMedium", 1,FontWeight.normal),
                  ],),
                  text(percentage == "100.0"? "Bitti" : "%$percentage", isReading ? colors.orange : colors.greenDark, 13, "FontMedium", 1,percentage == "100.0" ? FontWeight.normal : FontWeight.w700),
                ],
              ),
              Visibility( visible:isNotStarted == false, child: const SizedBox(height: 8,)),
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
                        bookInfo.imageLink,
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
                              isNotStarted ?
                              text("Planlanmadı", colors.black, 13, "FontMedium", 1, FontWeight.normal)
                                  :
                              text(isReading ? "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} / ${OkuurCalc.calcDaysBetween(bookInfo.startingDate, DateTime.now().toString())} gündür okuyorsun" : "${OkuurCalc.calcDaysBetween(bookInfo.startingDate,bookInfo.finishingDate)} günde okudunuz", colors.black, 11, "FontMedium", 1,FontWeight.normal),
                              moreButton(isReading ? colors.orange : colors.greenDark,!isNotStarted)
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
      ),
      Visibility(
        visible: isNotStarted == false,
        child: Container(
            margin: const EdgeInsets.only(left: 4),
            child: OkuurStarRating(rating: bookInfo.rating,filledStarColor:colors.greenDark,unfilledStarColor: isReading ? colors.blueLight :colors.blue,text: isReading ? "" : bookInfo.rating.toString(),)),
      )
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

InkWell moreButton(Color color,bool rate){
  return InkWell(
    onTapDown: (TapDownDetails details) {
      showOkuurPopupMenu(details.globalPosition, colors.white,rate ? 36 : 12,[
        PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.mode_edit_outline_rounded,color: colors.greenDark,size: 16),
              SizedBox(width: 6),
              Text('Düzenle',style: TextStyle(fontSize: 13,color: colors.greenDark),),
            ],
          ),
        ),
        rate ?
        PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.star_rate_rounded,color: colors.greenDark,size: 16),
              SizedBox(width: 6),
              Text('Puanla',style: TextStyle(fontSize: 13,color: colors.greenDark),),
            ],
          ),
        ) : PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.chrome_reader_mode_rounded,color: colors.green,size: 16),
              SizedBox(width: 6),
              Text('Okumaya başla',style: TextStyle(fontSize: 13,color: colors.green),),
            ],
          ),
        ),
        PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.delete_outline_rounded,color: colors.red,size: 16),
              SizedBox(width: 6),
              Text('Sil',style: TextStyle(fontSize: 13,color: colors.red),),
            ],
          ),
        ),
      ]);
    },
    child: Container(
      height: 11,
      margin: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 3),
      child: Image.asset("assets/icons/more.png"),
    ),
  );
}