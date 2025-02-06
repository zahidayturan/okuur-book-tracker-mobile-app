import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/regular_text.dart';

class BookListWidget extends StatefulWidget {

   const BookListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {

  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();

  List<OkuurBookInfo> currentBooks = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    List<OkuurBookInfo> books = await bookOperations.getCurrentlyReadBooksInfo();
    setState(() {
      currentBooks = books;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        RegularText(texts: "Şu An Okunanlar", color: colors.greenDark, family: "FontBold"),
        const SizedBox(height: 12,),
        ...currentBooks.map((item) => bookContainer(
          currentBookText(
            item.name,
            item.author,
            item.type,
            item.pageCount.toString(),
            item.startingDate,
            item.finishingDate,
            item.imageLink
          ),
        )).toList(),
        const SizedBox(height: 8),
      ],
    );
  }


  Widget bookContainer(Widget child){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BaseContainer(
        height: 112,
        child: child,
      ),
    );
  }

  Row currentBookText(String name,String author,String type,String page,String startedDate,String finishedDate,String image){
    DateTime? formattedDate;
    try {
      formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(startedDate);
    } catch (e) {
      debugPrint("Başlangıç tarihi format hatası: $e");
    }

    String finishingDate = "";

    if (formattedDate != null) {
      int differenceDay = DateTime.now().difference(formattedDate).inDays;
      finishingDate = differenceDay != 0 ? "$differenceDay gündür okuyor" : "Bugün başladı";
    } else {
      finishingDate = "Başlangıç tarihi geçersiz";
    }

    return Row(
      children: [
        Container(
            width: 58,
            height: 98,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(width: 1,color: Theme.of(context).scaffoldBackgroundColor)
            ),
            child: imageShower(image)
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(texts:name, color: colors.black, size: "l",  maxLines: 2,weight: FontWeight.bold,),
            RegularText(texts:author, color: colors.black, size: "m",),
            const Spacer(),
            RegularText(texts:"$type - $page sayfa", color: colors.black, size: "m"),
            const Spacer(),
            formattedDate != null ? RegularText(texts:"${formattedDate.day}.${formattedDate.month}.${formattedDate.year} / $finishingDate", color: colors.black, size: "m") : const RegularText(texts:"")
          ],
        )
      ],
    );
  }

}