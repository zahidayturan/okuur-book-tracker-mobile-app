import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/database_helper.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/routes/settings/settings.dart';

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


  List<OkuurBookInfo> tempBookList = [
    OkuurBookInfo(
        name: "Kitap 1",
        author: "Yazar 1",
        pageCount: 245,
        imageLink: 'https://picsum.photos/250?image=8',
        type: "type",
        startingDate:"startingDate",
        finishingDate: "finishingDate",
        currentPage: 145,
        readingTime: 220,
        status: 0,
        logIds:"1-"),
    OkuurBookInfo(
        name: "Kitap 2",
        author: "Yazar 2",
        pageCount: 245,
        imageLink: 'https://picsum.photos/250?image=8',
        type: "type",
        startingDate:"startingDate",
        finishingDate: "finishingDate",
        currentPage: 145,
        readingTime: 220,
        status: 1,
        logIds:"1-"),
    OkuurBookInfo(
        name: "Kitap 3",
        author: "Yazar 3",
        pageCount: 245,
        imageLink: 'https://picsum.photos/250?image=8',
        type: "type",
        startingDate:"startingDate",
        finishingDate: "finishingDate",
        currentPage: 145,
        readingTime: 220,
        status: 2,
        logIds:"1-"),
  ];

  List<OkuurBookInfo> currentBooks = [];
  List<OkuurBookInfo> futureBooks = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    List<OkuurBookInfo> books = await bookOperations.getBookInfo();
    List<OkuurBookInfo> current = [];
    List<OkuurBookInfo> future = [];

    for (var book in books) {
      int readStatus = book.status;
      print(readStatus % 2);
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
              text("Şu An Okunanlar", colors.greenDark, 15, "FontBold", 1),
              SizedBox(height: 12,),
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
              SizedBox(height: 12,),
              text("Okunan Bütün Eserler", colors.greenDark, 15, "FontBold", 1),
              SizedBox(height: 12,),
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
            borderRadius: BorderRadius.all(Radius.circular(24),),
            color: colors.orange
          ),
          child: RotatedBox(
              quarterTurns: 3,
              child: Center(child: text(index,colors.white,13,"FontBold",1))),
        ),
        Container(
          height: 112,
          width: size.width,
          margin: EdgeInsets.only(bottom: 12,left: 24),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.all(Radius.circular(14))
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
      print("Başlangıç tarihi format hatası: $e");
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
                    borderRadius: BorderRadius.only(
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
              margin: EdgeInsets.only(left: 4, bottom: 4),
              decoration: BoxDecoration(
                color: colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ],
        ),
        SizedBox(width: 6,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(name, colors.black, 15, "FontMedium", 2),
            text(author, colors.black, 13, "FontMedium", 1),
            text("$type - $page sayfa", colors.black, 13, "FontMedium", 1),
            formattedDate != null ? text("${formattedDate.day}.${formattedDate.month}.${formattedDate.year} / $finishingDate", colors.black, 13, "FontMedium", 1) : Text("")
          ],
        ),
      ],
    );
  }


  Text text(String text,Color color,double size, String family,int maxLines){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),overflow: TextOverflow.ellipsis,maxLines: maxLines,
    );
  }

}