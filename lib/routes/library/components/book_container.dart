import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/library_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/loading_circular.dart';
import 'package:okuur/ui/components/popup_operation_menu.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/star_rating.dart';
import 'package:okuur/ui/utils/date_formatter.dart';
import 'package:okuur/ui/utils/simple_calc.dart';
import '../../../ui/components/image_shower.dart';

AppColors colors = AppColors();
final LibraryController libraryController = Get.find();

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
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        if (!isNotStarted) _bookHeader(bookInfo, index, isReading, context, percentage),
        const SizedBox(height: 8),
        _bookContent(bookInfo, context, isNotStarted, isReading),
      ],
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
      moreButton(isReading ? colors.orange : Theme.of(context).colorScheme.tertiary, !isNotStarted, context, bookInfo),
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

InkWell moreButton(Color color, bool rate, BuildContext context, OkuurBookInfo bookInfo) {
  return InkWell(
    onTapDown: (TapDownDetails details) => _showMoreMenu(details, color, rate, context, bookInfo),
    child: Container(
      height: 11,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 3),
      child: Image.asset("assets/icons/more.png", color: Theme.of(context).primaryColor),
    ),
  );
}

void _showMoreMenu(TapDownDetails details, Color color, bool rate, BuildContext context, OkuurBookInfo bookInfo) {
  showOkuurPopupMenu(
    details.globalPosition,
    Theme.of(context).colorScheme.onPrimaryContainer,
    rate ? 36 : 12,
    _popupMenuItems(context, rate),
        (value) => _handlePopupMenuAction(value,bookInfo),
  );
}

List<PopupMenuEntry<int>> _popupMenuItems(BuildContext context, bool rate) {
  return [
    _buildMenuItem(context, Icons.mode_edit_outline_rounded, "Düzenle", Theme.of(context).colorScheme.primaryContainer, 1),
    if (rate) _buildMenuItem(context, Icons.star_rate_rounded, "Puanla", Theme.of(context).colorScheme.primaryContainer, 2),
    if (!rate) _buildMenuItem(context, Icons.chrome_reader_mode_rounded, "Okumaya başla", Theme.of(context).colorScheme.surface, 3),
    _buildMenuItem(context, Icons.delete_outline_rounded, "Sil", colors.red, 4),
  ];
}

PopupMenuItem<int> _buildMenuItem(BuildContext context, IconData icon, String text, Color color, int value) {
  return PopupMenuItem<int>(
    value: value,  // Menü öğesinin döneceği değer
    height: 32,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 13, color: color)),
      ],
    ),
  );
}

Future<void> _handlePopupMenuAction(int? value, OkuurBookInfo bookInfo) async {
  switch (value) {
    case 4:
      bool shouldDelete = await _showDeleteConfirmation(bookInfo.name);
      if (shouldDelete) {
        _showLoading("Kitap ve kayıtlar siliniyor");
        await _deleteBook(bookInfo);
        _hideLoading();
      }
      break;
  }
}

Future<void> _deleteBook(OkuurBookInfo bookInfo) async {
  try {
    await BookOperations().deleteBookAndLogInfo(bookInfo.id!);
    await libraryController.fetchBooks();
  } catch (e) {
    debugPrint("An error occurred: $e");
  }
}

Future<bool> _showDeleteConfirmation(String bookName) async {
  return await Get.dialog<bool>(
    AlertDialog(
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
            getAlertButton("Geri Dön", false, false),
            const SizedBox(width: 8),
            getAlertButton("Sil", true, true),
          ],
        ),
      ],
    ),
  ) ??
      false;
}

void _showLoading(String message) {
  LoadingDialog.showLoading(message: message);
}

void _hideLoading() {
  LoadingDialog.hideLoading();
}

Expanded getAlertButton(String text, bool isPop, bool fill) {
  return Expanded(
    child: InkWell(
      onTap: () => Get.back(result: isPop),
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