import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/controllers/library_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/alert_dialog.dart';
import 'package:okuur/ui/components/loading_circular.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/utils/validator.dart';

class AddBookButton extends StatefulWidget {
  const AddBookButton({Key? key}) : super(key: key);

  @override
  State<AddBookButton> createState() => _AddBookButtonState();
}

class _AddBookButtonState extends State<AddBookButton> {
  final AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();
  final AddBookController controller = Get.find();
  final LibraryController libraryController = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return addButton();
  }

  Future<void> _handleAddBook(BuildContext context) async {
    controller.checkAllValidate();
    if (!controller.bookAllValidate.value) {
      _showValidationErrors();
      return;
    }

    final bookInfo = _createBookInfo();
    LoadingDialog.showLoading(message: "Kitap ekleniyor");

    try {
      await bookOperations.insertBookInfo(bookInfo);
      await libraryController.fetchBooks();
      await homeController.fetchCurrentlyReadBooks();
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    } finally {
      LoadingDialog.hideLoading();
      Navigator.of(context).pop();
    }
  }

  OkuurBookInfo _createBookInfo() {
    String startingDate = "startingDate";
    String finishingDate = "finishingDate";
    int currentPage = 0;
    int status = 1;
    int readingTime = 0;
    double rating = 0;
    String imageLink = "none";

    if (controller.bookCurrentStatus.value != 2) {
      if (controller.bookInit.value == 0) {
        startingDate = DateTime.now().toString();
      }
      if (controller.bookCurrentStatus.value == 1) {
        currentPage = controller.bookCurrentPage.value;
        readingTime = (currentPage*1.5).toInt();
      }
      status = controller.bookInit.value == 0 ? 1 : 0;
    } else {
      startingDate = DateFormat('dd.MM.yyyy')
          .parse(controller.bookStartedDateController.text)
          .toString();
      finishingDate = DateFormat('dd.MM.yyyy')
          .parse(controller.bookFinishedDateController.text)
          .toString();
      currentPage = int.tryParse(controller.bookPageController.text)!;
      status = 2;
      readingTime = (currentPage * 1.5).toInt();
      rating = controller.bookRating.value;
    }

    return OkuurBookInfo(
      name: controller.bookNameController.text,
      author: controller.bookAuthorController.text,
      pageCount: int.tryParse(controller.bookPageController.text)!,
      imageLink: imageLink,
      type: controller.bookTypeController.text,
      startingDate: startingDate,
      finishingDate: finishingDate,
      currentPage: currentPage,
      readingTime: readingTime,
      status: status,
      logIds: "",
      rating: rating,
    );
  }

  void _showValidationErrors() {
    final pageCount = double.tryParse(controller.bookPageController.text);
    if (OkuurValidator.rangeValidate(pageCount, 1, 9999) == false) {
      showAlert("Uyarı", "Kitabın sayfa sayısı 0'dan büyük ve 10000'den küçük olmalıdır");
    } else {
      showAlert("Uyarı", "Lütfen kitabın bilgilerini eksiksiz ve doğru giriniz.");
    }
  }

  Widget addButton() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _handleAddBook(context),
            child: Container(
              decoration: BoxDecoration(
                color: colors.orange,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  child: RegularText(texts: "Kitabı Ekle",color: colors.white,size: "l"),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
