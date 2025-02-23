import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/regular_text.dart';
import '../../../ui/components/rich_text.dart';

class LogNameInfo extends StatefulWidget {
  const LogNameInfo({Key? key,}) : super(key: key);

  @override
  State<LogNameInfo> createState() => _LogNameInfoState();
}

class _LogNameInfoState extends State<LogNameInfo> {
  AppColors colors = AppColors();

  final AddLogController controller = Get.find();


  @override
  void initState() {
    super.initState();
    controller.fetchCurrentlyReadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        formContent(),
      ],
    );
  }

  Widget formContent() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            texts: const ["Kayıt Ekleyeceğiniz ","Kitabı Seçiniz"],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: const ["FontMedium","FontBold"],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              italicText("Okumakta olduğunuz kitaplardan seçim yapabilirsiniz."),
            ],
          ),
          const SizedBox(height: 12,),
          Obx(() => controller.booksLoading.value
              ? loadingBook()
              : controller.currentlyReadBooks.isNotEmpty
              ? bookList()
              : notFoundBook()),
        ],
      ),
    );
  }

  int? selectedBookIndex;


  Widget bookList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(controller.currentlyReadBooks.length, (index) {
          return bookOption(controller.currentlyReadBooks[index], index);
        }),
      ),
    );
  }


  Widget bookOption(OkuurBookInfo data,int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          if(selectedBookIndex != index){
            controller.clearAll();
          }
          selectedBookIndex = index;
        });
        controller.setLogBook(data.id!,data.pageCount,data.currentPage,data.name);
      },
      child: Container(
        width: 90,
        margin: EdgeInsets.only(left: index != 0 ? 24 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  height: 126,
                  width: 90,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: selectedBookIndex == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onPrimaryContainer,width: 2)
                  ),
                  child: selectedBookIndex == index || selectedBookIndex == null
                      ? imageShower(data.imageLink)
                      : imageShower(data.imageLink),
                ),
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  width: 28,
                  height: selectedBookIndex == index ? 28 : 0,
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  child: selectedBookIndex == index ? Icon(Icons.check_rounded,color: colors.grey,) : null,
                ),
              ],
            ),
            const SizedBox(height: 8,),
            RegularText(texts: data.name,size: "s",color: selectedBookIndex == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.secondary,align: TextAlign.center,)
          ],
        ),
      ),
    );
  }

  Widget italicText(String text) {
    return RegularText(
      texts: text,
      size: "s",
      style: FontStyle.italic,
      maxLines: 3,
    );
  }

  Widget notFoundBook() {
    return messageContainer(
      "Bir kitabı okumuyorsunuz. Yeni kitap ekleyin veya eklediklerinizden birini okumaya başlayın",
    );
  }


  Widget loadingBook() {
    return messageContainer(
      "Kitaplar yükleniyor...",
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }

  Widget messageContainer(String message, {Widget? child}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: Column(
          children: [
            if (child != null) ...[
              SizedBox(height: 24, width: 24, child: child),
              const SizedBox(height: 8),
            ],
            RegularText(
              texts: message,
              align: TextAlign.center,
              color: colors.blue,
              size: "l",
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}