import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/library_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/routes/bookDetail/book_detail.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/star_rating.dart';
import 'package:okuur/ui/utils/date_formatter.dart';
import 'package:okuur/ui/utils/simple_calc.dart';
import '../../../controllers/book_detail_controller.dart';
import '../../../ui/components/image_shower.dart';

AppColors colors = AppColors();
final LibraryController libraryController = Get.find();
final BookDetailController bookDetailController = Get.find();

Row bookContainerLibrary(OkuurBookInfo bookInfo, String index, BuildContext context) {
  bool isNotStarted = bookInfo.status == 0;
  bool isReading = bookInfo.status % 2 == 1;
  String percentage = OkuurCalc.calcPercentage(bookInfo.pageCount, bookInfo.currentPage).toStringAsFixed(1);

  return Row(
    children: [
      Expanded(child: _bookDetails(bookInfo, index, context, isNotStarted, isReading, percentage)),
      if (!isNotStarted && !isReading)
        _bookRating(bookInfo, isReading, context),
    ],
  );
}

Widget _bookDetails(OkuurBookInfo bookInfo, String index, BuildContext context, bool isNotStarted, bool isReading, String percentage) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),

    child: Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          bookDetailController.setBookInfo(bookInfo);
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
              libraryController.fetchBooks();
            }
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (!isNotStarted) _bookHeader(bookInfo, index, isReading, context, percentage),
              const SizedBox(height: 8),
              _bookContent(bookInfo, context, isNotStarted, isReading),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _bookHeader(OkuurBookInfo bookInfo, String index, bool isReading, BuildContext context, String percentage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          RegularText(texts:index, color: isReading ? colors.orange : Theme.of(context).colorScheme.secondary, size:"m", family: "FontBold"),
          _statusDot(isReading, context),
          RegularText(texts:
            isReading
                ? "Şu an okuyorsun"
                : "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} - ${OkuurDateFormatter.convertDate(bookInfo.finishingDate)}",
            color: isReading ? colors.orange : Theme.of(context).colorScheme.secondary,
            size: "m",
          ),
        ],
      ),
  RegularText(texts:percentage == "100.0" ? "Bitti" : "%$percentage", color: isReading ? colors.orange : Theme.of(context).colorScheme.tertiary, size: "m"),
    ],
  );
}

Widget _bookContent(OkuurBookInfo bookInfo, BuildContext context, bool isNotStarted, bool isReading) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _bookImage(bookInfo, context),
      const SizedBox(width: 8),
      Expanded(
        child: SizedBox(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(texts:bookInfo.name, size: "l", maxLines: 2, family: "FontBold"),
              _bookInfoText(bookInfo, context),
              _bookFooter(bookInfo, isNotStarted, isReading, context),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _bookImage(OkuurBookInfo bookInfo, BuildContext context) {
  return Container(
    width: 58,
    height: 90,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
    child: imageShower(bookInfo.imageLink),
  );
}

Widget _bookInfoText(OkuurBookInfo bookInfo, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RegularText(texts:bookInfo.author, size:"m"),
      RegularText(texts:"${bookInfo.type} - ${bookInfo.pageCount} sayfa"),
      const SizedBox(height: 2),
    ],
  );
}

Widget _bookFooter(OkuurBookInfo bookInfo, bool isNotStarted, bool isReading, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      RegularText(texts:
        isNotStarted
            ? "Planlanmadı"
            : isReading
            ? "${OkuurDateFormatter.convertDate(bookInfo.startingDate)} / ${OkuurCalc.calcDaysBetween(bookInfo.startingDate, DateTime.now().toString())} gündür okuyorsun"
            : "${OkuurCalc.calcDaysBetween(bookInfo.startingDate, bookInfo.finishingDate)} günde okudunuz",
        size: "xs"
      ),
      moreButton(isReading ? colors.orange : Theme.of(context).colorScheme.tertiary, context, bookInfo),
    ],
  );
}

Widget _bookRating(OkuurBookInfo bookInfo, bool isReading, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 4),
    child: OkuurStarRating(
      rating: bookInfo.rating,
      filledStarColor: Theme.of(context).colorScheme.tertiary,
      unfilledStarColor: isReading ? colors.blueLight : colors.blue,
      text: isReading ? "" : bookInfo.rating.toString(),
    ),
  );
}

Widget _statusDot(bool isReading, BuildContext context) {
  return Container(
    width: 4,
    height: 4,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isReading ? colors.orange : Theme.of(context).colorScheme.secondary,
    ),
  );
}

SizedBox moreButton(Color color, BuildContext context, OkuurBookInfo bookInfo) {
  return SizedBox(
    height: 11,
    child: Image.asset("assets/icons/arrow.png", color: color),
  );
}