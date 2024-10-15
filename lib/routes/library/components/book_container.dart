import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/library_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/popup_operation_menu.dart';
import 'package:okuur/ui/components/star_rating.dart';
import 'package:okuur/ui/utils/date_formatter.dart';
import 'package:okuur/ui/utils/simple_calc.dart';

import '../../../ui/components/image_shower.dart';

AppColors colors = AppColors();
final LibraryController libraryController = Get.find();


Row bookContainerLibrary(OkuurBookInfo bookInfo,String index,BuildContext context){
  bool isNotStarted = bookInfo.status == 0;
  bool isReading = bookInfo.status %2 == 1;
  String percentage = OkuurCalc.calcPercentage(bookInfo.pageCount,bookInfo.currentPage);
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                    text(index,isReading ? colors.orange : Theme.of(context).colorScheme.secondary,13,"FontBold",1,FontWeight.normal),
                    Container(width: 4,height: 4,margin:const EdgeInsets.symmetric(horizontal: 4),decoration: BoxDecoration(shape: BoxShape.circle,color: isReading ? colors.orange : Theme.of(context).colorScheme.secondary),),
                    text(isReading ? "Şu an okuyorsun" : "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} - ${OkuurDateFormatter.convertDate(bookInfo.finishingDate)}", isReading ? colors.orange : Theme.of(context).colorScheme.secondary, 13, "FontMedium", 1,FontWeight.normal),
                  ],),
                  text(percentage == "100.0"? "Bitti" : "%$percentage", isReading ? colors.orange : Theme.of(context).colorScheme.tertiary, 13, "FontMedium", 1,percentage == "100.0" ? FontWeight.normal : FontWeight.w700),
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
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    child: imageShower(bookInfo.imageLink)
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: SizedBox(
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                        children: [
                          text(bookInfo.name, Theme.of(context).colorScheme.secondary, 15, "FontMedium", 2,FontWeight.bold),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(bookInfo.author, Theme.of(context).colorScheme.secondary, 13, "FontMedium", 1,FontWeight.normal),
                              text("${bookInfo.type} - ${bookInfo.pageCount} sayfa", Theme.of(context).colorScheme.secondary, 12, "FontMedium", 1,FontWeight.normal),
                              const SizedBox(height: 2,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              isNotStarted ?
                              text("Planlanmadı", Theme.of(context).colorScheme.secondary, 13, "FontMedium", 1, FontWeight.normal)
                                  :
                              text(isReading ? "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} / ${OkuurCalc.calcDaysBetween(bookInfo.startingDate, DateTime.now().toString())} gündür okuyorsun" : "${OkuurCalc.calcDaysBetween(bookInfo.startingDate,bookInfo.finishingDate)} günde okudunuz", Theme.of(context).colorScheme.secondary, 11, "FontMedium", 1,FontWeight.normal),
                              moreButton(isReading ? colors.orange : Theme.of(context).colorScheme.tertiary,!isNotStarted,context,bookInfo)
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
        visible: !isNotStarted && !isReading,
        child: Container(
            margin: const EdgeInsets.only(left: 4),
            child: OkuurStarRating(rating: bookInfo.rating,filledStarColor:Theme.of(context).colorScheme.tertiary,unfilledStarColor: isReading ? colors.blueLight :colors.blue,text: isReading ? "" : bookInfo.rating.toString(),)),
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

InkWell moreButton(Color color,bool rate,BuildContext context,OkuurBookInfo bookInfo){
  return InkWell(
    onTapDown: (TapDownDetails details) {
      showOkuurPopupMenu(details.globalPosition, Theme.of(context).colorScheme.onPrimaryContainer,rate ? 36 : 12,[
        PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.mode_edit_outline_rounded,color: Theme.of(context).colorScheme.primaryContainer,size: 16),
              const SizedBox(width: 6),
              Text('Düzenle',style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.primaryContainer),),
            ],
          ),
        ),
        rate ?
        PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.star_rate_rounded,color: Theme.of(context).colorScheme.primaryContainer,size: 16),
              const SizedBox(width: 6),
              Text('Puanla',style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.primaryContainer),),
            ],
          ),
        ) : PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.chrome_reader_mode_rounded,color: Theme.of(context).colorScheme.surface,size: 16),
              const SizedBox(width: 6),
              Text('Okumaya başla',style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.surface),),
            ],
          ),
        ),
        PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          value: 4,
          child: Row(
            children: [
              Icon(Icons.delete_outline_rounded,color: colors.red,size: 16),
              const SizedBox(width: 6),
              Text('Sil',style: TextStyle(fontSize: 13,color: colors.red),),
            ],
          ),
        ),
      ],(value) async {
        switch (value) {
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
          case 4:
            bool shouldDelete = await _showDeleteConfirmation(context, bookInfo.name);
            if (shouldDelete) {
              await BookOperations().deleteBookInfo(bookInfo.id!);
              await libraryController.fetchBooks();
            }
            break;
        }
      },);
    },
    child: Container(
      height: 11,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 3),
      child: Image.asset("assets/icons/more.png",color: Theme.of(context).primaryColor,),
    ),
  );

}


Future<bool> _showDeleteConfirmation(BuildContext context,String bookName) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        "$bookName\nKitap ve kayıtları silinecek!\nEmin misiniz?",
        textAlign: TextAlign.center,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      actions: [
        Row(
          children: [
            getAlertButton("Geri Dön", false, false, context),
            const SizedBox(width: 8),
            getAlertButton("Sil", true, true, context),
          ],
        ),
      ],
    ),
  ) ??
      false;
}

Expanded getAlertButton(String text, bool isPop, bool fill, BuildContext context) {
  return Expanded(
    child: InkWell(
      onTap: () => Navigator.of(context).pop(isPop),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: fill ? colors.blue : null,
          border: fill ? null : Border.all(color: colors.blue, width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: fill ? colors.white : colors.blue,
            ),
          ),
        ),
      ),
    ),
  );
}