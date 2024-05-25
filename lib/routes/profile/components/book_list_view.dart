import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
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


  List<Map<String, String>> tempBookList = [
    {
      'id': '1',
      'name': 'Books 1',
      'author': 'Author 1',
      'page': '248',
      'currentPage': '120',
      'image': 'https://picsum.photos/250?image=9',
      'type': 'Type 1',
      'startDate': '15.05.2024',
      'endDate': '15.05.2024',
      'readTime': '254',
      'readingLogs': '4',
      'readStatus': '0',
    },
    {
      'id': '2',
      'name': 'Books 2',
      'author': 'Author 2',
      'page': '124',
      'currentPage': '124',
      'image': 'https://picsum.photos/250?image=8',
      'type': 'Type 2',
      'startDate': '14.05.2024',
      'endDate': '14.05.2024',
      'readTime': '155',
      'readingLogs': '5',
      'readStatus': '1',
    },
  ];

  List<Map<String, String>> currentBooks = [];
  List<Map<String, String>> futureBooks = [];

  @override
  void initState() {
    for (var book in tempBookList) {
      int readStatus = int.parse(book['readStatus']!);
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

    List<Map<String, String>> allBooks = [...currentBooks, ...futureBooks];
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
            itemCount: futureBooks.length,
            itemBuilder: (context, index) {
              Map<String, String> item = futureBooks[index];
              return bookContainer(
                currentBookText(
                  item['name']!,
                  item['author']!,
                  item['type']!,
                  item['page']!,
                  item['startDate']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Container bookContainer(Widget child){
    return Container(
      height: 112,
      width: 30,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: child,
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