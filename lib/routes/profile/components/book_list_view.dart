import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
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
    for (var book in tempBookList) {
      int readStatus = book.status;
      if (readStatus % 2 == 0) {
        currentBooks.add(book);
      } else {
        futureBooks.add(book);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<OkuurBookInfo> allBooks = [...currentBooks, ...futureBooks];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("Şu An Okunanlar", colors.greenDark, 15, "FontBold", 1),
        SizedBox(height: 12,),

        text("Okunan Bütün Eserler", colors.greenDark, 15, "FontBold", 1),
        SizedBox(height: 12,),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: allBooks.length,
            itemBuilder: (context, index) {
              OkuurBookInfo item = allBooks[index];
              return bookContainer(
                currentBookText(
                  item.name,
                  item.author,
                  item.type,
                  item.pageCount.toString(),
                  item.startingDate,
                ),"${index+1}",
              );
            },
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
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: child,
        ),
      ],
    );
  }

  Column currentBookText(String name,String author,String type,String page,String date){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(name, colors.black, 15, "FontMedium", 2),
        text(author, colors.black, 13, "FontMedium", 1),
        text(page, colors.black, 13, "FontMedium", 1),
        text(date, colors.black, 13, "FontMedium", 1)
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