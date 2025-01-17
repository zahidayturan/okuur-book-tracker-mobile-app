import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/ui/components/regular_text.dart';

class BookListWidget extends StatefulWidget {

  //final OkuurUserInfo userData;

  const BookListWidget({
    Key? key,
    //required this.userData
  }) : super(key: key);

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {

  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();


  List<OkuurBookInfo> currentBooks = [];
  List<OkuurBookInfo> futureBooks = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    List<OkuurBookInfo> books = await bookOperations.getBookInfo() ?? [];
    List<OkuurBookInfo> current = [];
    List<OkuurBookInfo> future = [];

    for (var book in books) {
      int readStatus = book.status;
      debugPrint("blist status ${(readStatus % 2).toString()}");
      if(readStatus != 0){
        if (readStatus % 2 == 1) {
          current.add(book);
        } else {
          future.add(book);
        }
      }
    }

    setState(() {
      currentBooks = current;
      futureBooks = future;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            children: [
              RegularText(texts: "Şu An Okunanlar", color: colors.greenDark, size: "l", family: "FontBold"),
              const SizedBox(height: 12,),
              ...currentBooks.map((item) => bookContainer(
                currentBookText(
                  item.name,
                  item.author,
                  item.type,
                  item.pageCount.toString(),
                  item.startingDate,
                  item.finishingDate,
                  item.imageLink,
                  true
                ),
                "${currentBooks.indexOf(item) + 1}",
              )).toList(),
              const SizedBox(height: 12,),
              RegularText(texts: "Okunan Bütün Eserler", color: colors.greenDark, size: "l", family: "FontBold"),
              const SizedBox(height: 12,),
              ...futureBooks.map((item) => bookContainer(
                currentBookText(
                  item.name,
                  item.author,
                  item.type,
                  item.pageCount.toString(),
                  item.startingDate,
                  item.finishingDate,
                  item.imageLink,
                  false
                ),
                "${currentBooks.length + futureBooks.indexOf(item) + 1}",
              )).toList(),
            ],
          ),
        ),
      ],
    );
  }


  Widget bookContainer(Widget child,String index){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: 28,height: 112,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24),),
            color: colors.orange
          ),
          child: RotatedBox(
              quarterTurns: 3,
              child: Center(child: RegularText(texts:index,color:colors.white,size:"m", family: "FontBold"))),
        ),
        Container(
          height: 112,
          width: size.width,
          margin: const EdgeInsets.only(bottom: 12,left: 24),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(14))
          ),
          child: child,
        ),
      ],
    );
  }

  Row currentBookText(String name,String author,String type,String page,String startedDate,String finishedDate,String image,bool isReading){
    DateTime? formattedDate;
    try {
      formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(startedDate);
    } catch (e) {
      debugPrint("Başlangıç tarihi format hatası: $e");
    }

    String finishingDate = "";
    if (isReading) {
      if (formattedDate != null) {
        int differenceDay = DateTime.now().difference(formattedDate).inDays;
        finishingDate = differenceDay != 0 ? "$differenceDay gündür okuyor" : "Bugün başladı";
      } else {
        finishingDate = "Başlangıç tarihi geçersiz";
      }
    } else {
      DateTime? formattedFinishDate;
      try {
        formattedFinishDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(finishedDate);
      } catch (e) {
        debugPrint("err #157");
      }

      if (formattedFinishDate != null) {
        finishingDate = "${formattedFinishDate.day}.${formattedFinishDate.month}.${formattedFinishDate.year}";
      } else {
        finishingDate = "Bitiş tarihi yok";
      }
    }

    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    color: colors.blueLight,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4)
                    )

                ),
              ),
            ),
            Container(
              width: 58,
              height: 90,
              margin: const EdgeInsets.only(left: 4, bottom: 4),
              decoration: BoxDecoration(
                color: colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ],
        ),
        const SizedBox(width: 6,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(texts:name, color: colors.black, size: "l",  maxLines: 2),
            RegularText(texts:author, color: colors.black, size: "m",),
            RegularText(texts:"$type - $page sayfa", color: colors.black, size: "m"),
            formattedDate != null ? RegularText(texts:"${formattedDate.day}.${formattedDate.month}.${formattedDate.year} / $finishingDate", color: colors.black, size: "m") : const RegularText(texts:"")
          ],
        ),
      ],
    );
  }

}